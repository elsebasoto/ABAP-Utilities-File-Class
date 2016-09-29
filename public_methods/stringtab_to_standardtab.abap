**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD stringtab_to_standardtab.

  DATA: ol_t_reference TYPE REF TO data,
        ol_w_reference TYPE REF TO data.

  DATA: tl_split       TYPE stringtab.

  DATA: vl_input       TYPE string,
        vl_split       TYPE string.

  FIELD-SYMBOLS: <fsl_t_output> TYPE ANY TABLE,
                 <fsl_w_output> TYPE ANY,
                 <fsl_v_field>  TYPE ANY.

***
* 1.- Create a data object like the output
***
  CREATE DATA ol_t_reference LIKE output.

  CHECK ol_t_reference IS BOUND.
  ASSIGN ol_t_reference->* TO <fsl_t_output>.
  IF sy-subrc <> 0.
    MESSAGE e011(saplwspo) WITH 'OUTPUT' ''.
  ENDIF.

  CREATE DATA ol_w_reference LIKE LINE OF <fsl_t_output>.

***
* 2.- Loop the input data
***
  LOOP AT input INTO vl_input.

***
* 2.1- Split the string line
***
    SPLIT vl_input AT split INTO TABLE tl_split.

***
* 2.2- Create a structure like line of output table.
***
    ASSIGN ol_w_reference->* TO <fsl_w_output>.

    LOOP AT tl_split INTO vl_split.

      ASSIGN COMPONENT sy-tabix
      OF STRUCTURE <fsl_w_output>
      TO <fsl_v_field>.

      IF <fsl_v_field> IS NOT ASSIGNED.
        MESSAGE e036(afwbm_main) RAISING assign_error.
*       Internal error in the tool for assigning characteristic values
      ENDIF.

      <fsl_v_field> = vl_split.

    ENDLOOP.

    INSERT <fsl_w_output> INTO TABLE <fsl_t_output>.

  ENDLOOP.

***
* 3.- Fill output table
***
  output = <fsl_t_output>.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
