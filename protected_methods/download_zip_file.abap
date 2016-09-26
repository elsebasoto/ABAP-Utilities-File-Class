**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Protected
**************************************************************************

METHOD download_zip_file.

  DATA: wl_file_tab_zip TYPE solisti1.

  OPEN DATASET filename FOR OUTPUT IN BINARY MODE.

  IF sy-subrc EQ 0.
    LOOP AT file_tab_zip INTO wl_file_tab_zip.
      TRANSFER wl_file_tab_zip TO filename.
    ENDLOOP.
  ELSE.
    MESSAGE i012(ba) WITH filename.
*   Cannot open archive file &
  ENDIF.

  CLOSE DATASET filename.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
