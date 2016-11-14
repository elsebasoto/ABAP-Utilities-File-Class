**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD standardtab_to_stringtab.

  DATA: wl_line         TYPE string,
        vl_splitter     TYPE abap_char1,
        vl_field        TYPE i VALUE 0,
        vl_type         TYPE c LENGTH 1,
        vl_charlike_aux TYPE c LENGTH 12.


  FIELD-SYMBOLS: <fsl_input> TYPE ANY,
                 <fsl_field> TYPE ANY.

  LOOP AT input ASSIGNING <fsl_input>.

    DO.

      vl_field = vl_field + 1.
      ASSIGN COMPONENT vl_field OF STRUCTURE <fsl_input> TO <fsl_field>.
      IF sy-subrc NE 0.
        APPEND wl_line TO output.
        EXIT.
      ENDIF.

      IF wl_line IS INITIAL.
        wl_line = <fsl_field>.
      ELSE.

        DESCRIBE FIELD <fsl_field> TYPE vl_type.

        IF vl_type EQ 'I' OR vl_type EQ 'P'.

          vl_charlike_aux = <fsl_field>.
          CONCATENATE wl_line
                      vl_splitter
                      vl_charlike_aux
          INTO wl_line.

        ELSE.

          CONCATENATE wl_line
                      vl_splitter
                      <fsl_field>
                 INTO wl_line.

        ENDIF.

      ENDIF.

    ENDDO.

    CLEAR: wl_line,
           vl_field.

  ENDLOOP.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
