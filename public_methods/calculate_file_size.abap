**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD calculate_file_size.

  FIELD-SYMBOLS: <fsl_data> TYPE ANY.

  DATA: vl_size TYPE i,
        vl_data TYPE string.

  CASE type.
    WHEN 'ASC'.

      LOOP AT data ASSIGNING <fsl_data>.
        DESCRIBE FIELD <fsl_data> LENGTH vl_size IN CHARACTER MODE.
        size = size  + vl_size.
      ENDLOOP.

    WHEN 'BIN'.

      LOOP AT data INTO vl_data.
        ASSIGN vl_data TO <fsl_data>.
        vl_size = STRLEN( <fsl_data> ).
        size = size  + vl_size.
      ENDLOOP.

    WHEN OTHERS.

      MESSAGE e873(td) WITH type RAISING format_not_supported.
*     Format & not supported

  ENDCASE.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
