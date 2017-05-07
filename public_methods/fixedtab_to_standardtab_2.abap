**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD fixedtab_to_standardtab_2.

  DATA: ol_t_reference TYPE REF TO data,
        ol_w_reference TYPE REF TO data.

  DATA: vl_input   TYPE string,
        vl_length  TYPE int4,
        vl_cant_long TYPE i,
        vl_aggregate TYPE int4.

  FIELD-SYMBOLS: <fsl_t_output> TYPE ANY TABLE,
                 <fsl_w_output> TYPE ANY,
                 <fsl_v_field>  TYPE ANY.

***
* 1.- Create a data object like the output table structure
***
  CREATE DATA ol_t_reference LIKE output.

  CHECK ol_t_reference IS BOUND.
  ASSIGN ol_t_reference->* TO <fsl_t_output>.
  IF sy-subrc <> 0.
    MESSAGE e011(saplwspo) WITH 'OUTPUT' ''.
  ENDIF.

  CREATE DATA ol_w_reference LIKE LINE OF <fsl_t_output>.

***
* 2.- Loop the input table
***
  LOOP AT input INTO vl_input.

***
* 2.1- Create a structure.
***
    ASSIGN ol_w_reference->* TO <fsl_w_output>.

    DO.

***
* 2.2- Asigno los componentes
***
      ASSIGN COMPONENT sy-index OF STRUCTURE <fsl_w_output> TO <fsl_v_field>.
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.

***
* 2.3- Get the destination length
***
      DESCRIBE FIELD <fsl_v_field> LENGTH vl_length IN BYTE MODE.

      IF vl_aggregate IS INITIAL.
        <fsl_v_field> = vl_input(vl_length).
        vl_aggregate = vl_length.
      ELSE.

        TRY.
            <fsl_v_field> = vl_input+vl_aggregate(vl_length).
          CATCH cx_sy_range_out_of_bounds.
***
*      This exception raise when the last field length is less long
* 2.4- at the field in the destination structure.
*      With a recursive method to reduce at 1 the length by each try.
            CALL METHOD zcl_ca_file_utilities=>catch_too_long
              EXPORTING
                input     = vl_input
                aggregate = vl_aggregate
              CHANGING
                length    = vl_length
                field     = <fsl_v_field>.

        ENDTRY.

        vl_aggregate = vl_aggregate + vl_length.
      ENDIF.

    ENDDO.

***
* 3.- Move the data
***
    CHECK ol_w_reference IS BOUND.
    ASSIGN ol_w_reference->* TO <fsl_w_output>.
    IF sy-subrc <> 0.
      MESSAGE e011(saplwspo) WITH '<FSL_W_OUTPUT>' ''.
    ENDIF.

    INSERT <fsl_w_output> INTO TABLE <fsl_t_output>.

    CLEAR vl_aggregate.

  ENDLOOP.

***
* 4.- Fill the output table
***
  output = <fsl_t_output>.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.4.3 - E.G.Mellodew. 1998-2017. Sap Release 731
