**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD fixedtab_to_standardtab.

  DATA: ol_t_reference TYPE REF TO data,
        ol_w_reference TYPE REF TO data.

  DATA: vl_input    TYPE string,
        vl_len      TYPE int4,
        vl_quan_len TYPE i,
        vl_sum      TYPE int4.

  FIELD-SYMBOLS: <fsl_t_output> TYPE ANY TABLE,
                 <fsl_w_output> TYPE ANY,
                 <fsl_v_field>  TYPE ANY.

***
* 1.- Create the data object like the output
***
  CREATE DATA ol_t_reference LIKE output.

  CHECK ol_t_reference IS BOUND.
  ASSIGN ol_t_reference->* TO <fsl_t_output>.
  IF sy-subrc NE 0.
    MESSAGE e011(saplwspo) WITH 'OUTPUT' ''.
  ENDIF.

  CREATE DATA ol_w_reference LIKE LINE OF <fsl_t_output>.

***
* 2.- How many splits
***
  vl_quan_len = LINES( lengths ).

***
* 3.- Read the input data
***
  LOOP AT input INTO vl_input.

***
* 3.1- Create a work area like the output table
***
    ASSIGN ol_w_reference->* TO <fsl_w_output>.

    DO vl_quan_len TIMES.

***
* 3.2- Assign the fields
***
      ASSIGN COMPONENT sy-index OF STRUCTURE <fsl_w_output> TO <fsl_v_field>.
      IF sy-subrc <> 0.
        MESSAGE e036(afwbm_main) RAISING assign_error.
*       Internal error in the tool for assigning characteristic values
      ENDIF.

      READ TABLE lengths
      INTO vl_len
      INDEX sy-index.

      IF vl_sum IS INITIAL.
        <fsl_v_field> = vl_input(vl_len).
        vl_sum = vl_len.
      ELSE.
        <fsl_v_field> = vl_input+vl_sum(vl_len).
        vl_sum = vl_sum + vl_len.
      ENDIF.

    ENDDO.

***
* 4.- Fill the output reference
***
    CHECK ol_w_reference IS BOUND.
    ASSIGN ol_w_reference->* TO <fsl_w_output>.
    IF sy-subrc <> 0.
      MESSAGE e011(saplwspo) WITH '<FSL_W_OUTPUT>' ''.
    ENDIF.

    INSERT <fsl_w_output> INTO TABLE <fsl_t_output>.

    CLEAR vl_sum.

  ENDLOOP.

***
* 5.- Fill the output table
***
  output = <fsl_t_output>.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
