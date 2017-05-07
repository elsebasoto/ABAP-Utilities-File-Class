**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD standardtab_to_stringtab.

  DATA: ol_data_float   TYPE REF TO data.

  DATA: wl_line         TYPE string,
        vl_field        TYPE i VALUE 0,
        vl_type         TYPE c LENGTH 1,
        vl_charlike_aux TYPE c LENGTH 12.

  FIELD-SYMBOLS: <fsl_input>  TYPE any,
                 <fsl_field>  TYPE any,
                 <fsl_packed> TYPE any.

  CREATE DATA ol_data_float TYPE p DECIMALS decimals_float.
  ASSIGN ol_data_float->* TO <fsl_packed>.

  LOOP AT input ASSIGNING <fsl_input>.

    DO.

      vl_field = vl_field + 1.
      ASSIGN COMPONENT vl_field OF STRUCTURE <fsl_input> TO <fsl_field>.
      IF sy-subrc NE 0.
        APPEND wl_line TO output.
        EXIT.
      ENDIF.

      IF wl_line IS INITIAL.
        CONCATENATE enclosed
                    <fsl_field>
                    enclosed
        INTO wl_line.
      ELSE.

        DESCRIBE FIELD <fsl_field> TYPE vl_type.

        IF vl_type CA 'IPsb'.

          vl_charlike_aux = <fsl_field>.
          CONDENSE vl_charlike_aux.
          CONCATENATE wl_line
                      splitter
                      enclosed
                      vl_charlike_aux
                      enclosed
          INTO wl_line.

        ELSEIF vl_type EQ 'F'. " Float

          CALL FUNCTION 'MURC_ROUND_FLOAT_TO_PACKED'
            EXPORTING
              if_float  = <fsl_field>
            IMPORTING
              ef_packed = <fsl_packed>
            EXCEPTIONS
              OTHERS    = 0.

          vl_charlike_aux = <fsl_packed>.
          CONDENSE vl_charlike_aux.
          CONCATENATE wl_line
                      splitter
                      enclosed
                      vl_charlike_aux
                      enclosed
          INTO wl_line.

        ELSE.

          CONCATENATE wl_line
                      splitter
                      enclosed
                      <fsl_field>
                      enclosed
                 INTO wl_line.

        ENDIF.

      ENDIF.

    ENDDO.

    CLEAR: wl_line,
           vl_field.

  ENDLOOP.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.4.3 - E.G.Mellodew. 1998-2017. Sap Release 731
