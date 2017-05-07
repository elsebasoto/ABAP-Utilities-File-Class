**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD merge_otf_into_1_pdf.

  DATA: tl_final_otf TYPE tsfotf,
        tl_lines     TYPE STANDARD TABLE OF tline.

  DATA: wl_otf_tabs  TYPE LINE OF ty_t_otf.

  DATA: vl_tabix     TYPE sy-tabix.

  LOOP AT otf_tabs INTO wl_otf_tabs.

    IF wl_otf_tabs-copies EQ 0.
      wl_otf_tabs-copies = 1.
    ENDIF.

    DO wl_otf_tabs-copies TIMES.

      IF tl_final_otf IS INITIAL.
        tl_final_otf = wl_otf_tabs-otf.
        CONTINUE.
      ENDIF.

*     Find the end of page in the OTF
      LOOP AT tl_final_otf TRANSPORTING NO FIELDS WHERE tdprintcom = 'EP'.
      ENDLOOP.
      vl_tabix = sy-tabix + 1.

*     Remove the begin and end marks
      DELETE wl_otf_tabs-otf WHERE tdprintcom = '//'.

*     Add the partial OTF to the final
      INSERT LINES OF wl_otf_tabs-otf INTO tl_final_otf INDEX vl_tabix.

    ENDDO.

  ENDLOOP.

* Convert OTF to PDF
  CALL FUNCTION 'CONVERT_OTF'
    EXPORTING
      format                = 'PDF'
      max_linewidth         = 132
    IMPORTING
      bin_filesize          = filesize
      bin_file              = pdf
    TABLES
      otf                   = tl_final_otf
      lines                 = tl_lines
    EXCEPTIONS
      err_max_linewidth     = 1
      err_format            = 2
      err_conv_not_possible = 3
      err_bad_otf           = 4
      OTHERS                = 5.

  IF sy-subrc NE 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.4.3 - E.G.Mellodew. 1998-2017. Sap Release 731
