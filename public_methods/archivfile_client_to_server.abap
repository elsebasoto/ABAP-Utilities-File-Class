**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD archivfile_client_to_server.

  DATA: lt_asc TYPE stringtab.

  DATA: lv_asc TYPE string,
        lv_rc  TYPE i.

* Read the source file
  CALL METHOD cl_gui_frontend_services=>gui_upload
    EXPORTING
      filename                = source
    CHANGING
      data_tab                = lt_asc
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      not_supported_by_gui    = 17
      error_no_gui            = 18
      OTHERS                  = 19.

  IF sy-subrc NE 0.

    RAISE EXCEPTION TYPE cx_t100_msg
      EXPORTING
        t100_msgid = '/BOBF/COM_GENERATOR'
        t100_msgno = 229
        t100_msgv1 = 'CL_GUI_FRONTEND_SERVICES'
        t100_msgv2 = 'GUI_UPLOAD'.

  ENDIF.

* Try open the target file
  OPEN DATASET target FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.

* Exit with false if can not open the file
  IF sy-subrc NE 0.

    RAISE EXCEPTION TYPE cx_t100_msg
      EXPORTING
        t100_msgid = 'HRPSGB_HER'
        t100_msgno = 044.

  ENDIF.

  LOOP AT lt_asc INTO lv_asc.
    TRANSFER lv_asc TO target.
  ENDLOOP.

  CLOSE DATASET target.

  IF move EQ abap_true.

    CALL METHOD cl_gui_frontend_services=>file_delete
      EXPORTING
        filename             = source
      CHANGING
        rc                   = lv_rc
      EXCEPTIONS
        file_delete_failed   = 1
        cntl_error           = 2
        error_no_gui         = 3
        file_not_found       = 4
        access_denied        = 5
        unknown_error        = 6
        not_supported_by_gui = 7
        wrong_parameter      = 8
        OTHERS               = 9.

    IF sy-subrc NE 0
    OR lv_rc    NE 0.

      RAISE EXCEPTION TYPE cx_t100_msg
        EXPORTING
          t100_msgid = '/BOBF/COM_GENERATOR'
          t100_msgno = 229
          t100_msgv1 = 'CL_GUI_FRONTEND_SERVICES'
          t100_msgv2 = 'FILE_DELETE'.

    ENDIF.

  ENDIF.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.4.3 - E.G.Mellodew. 1998-2017. Sap Release 731
