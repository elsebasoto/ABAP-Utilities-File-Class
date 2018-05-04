**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD convert_generic_to_string.

  DATA: lo_handle TYPE REF TO cl_abap_structdescr,
        lo_charlike TYPE REF TO data.

  DATA: lw_components TYPE LINE OF abap_compdescr_tab.

  DATA: lv_all     TYPE i,
        lv_length  TYPE i.

  FIELD-SYMBOLS: <fsl_field> TYPE any,
                 <fsl_charlike>   TYPE any.

* Inspecciono la definición del input
  lo_handle ?= cl_abap_datadescr=>describe_by_data( input ).

  LOOP AT lo_handle->components INTO lw_components.

    ASSIGN COMPONENT sy-tabix OF STRUCTURE input TO <fsl_field>.

*   Recupero el largo máximo definido en <FSL_FIELD>
    lv_length = zcl_ca_file_utilities=>get_length( <fsl_field> ).

*   Creo un tipo de dato de character con el largo máximo
    CREATE DATA lo_charlike TYPE c LENGTH lv_length.

    ASSIGN lo_charlike->* TO <fsl_charlike>.

*   Convierto a character el valor
    IF output_format EQ abap_true.
      WRITE <fsl_field> TO <fsl_charlike>.
    ELSE.
      <fsl_charlike> = <fsl_field>.
    ENDIF.

*   Agrego al string
    CONCATENATE output(lv_all)
                <fsl_charlike>
    INTO output
    RESPECTING BLANKS.

    ADD lv_length TO lv_all.

  ENDLOOP.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2018. Sap Release 731
