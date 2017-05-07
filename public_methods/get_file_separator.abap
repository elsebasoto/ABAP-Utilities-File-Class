**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD get_file_separator.

  IF batch EQ abap_false.

    CALL METHOD cl_gui_frontend_services=>get_file_separator
      CHANGING
        file_separator       = file_separator
      EXCEPTIONS
        not_supported_by_gui = 1
        error_no_gui         = 2
        cntl_error           = 3
        OTHERS               = 4.

    CASE sy-subrc.
      WHEN 1.
        RAISE not_supported_by_gui.
      WHEN 2.
        RAISE error_no_gui.
      WHEN 3.
        RAISE cntl_error.
    ENDCASE.

  ELSE.

    CASE sy-opsys.
      WHEN 'Windows NT'.
        file_separator = '\'.
      WHEN 'Linux'.
        file_separator = '/'.
      WHEN 'HP-UX'.
        file_separator = '/'.
      WHEN 'OS400'.
        file_separator = '/'.
      WHEN OTHERS.
        file_separator = '/'.
    ENDCASE.

  ENDIF.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.4.3 - E.G.Mellodew. 1998-2017. Sap Release 731
