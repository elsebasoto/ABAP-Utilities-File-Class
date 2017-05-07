**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD archivfile_server_to_server.

  DATA: lt_asc TYPE stringtab.

  DATA: lv_asc TYPE string.

* Try open the source file
  OPEN DATASET source FOR INPUT IN TEXT MODE ENCODING DEFAULT.

* Exit with false if can not open the file
  IF sy-subrc NE 0.

    RAISE EXCEPTION TYPE cx_t100_msg
      EXPORTING
        t100_msgid = '5M'
        t100_msgno = 314.

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

* Transfer the content
  DO.

    READ DATASET source INTO lv_asc.

    IF sy-subrc NE 0.
      EXIT.
    ENDIF.

    TRANSFER lv_asc TO target.

  ENDDO.

* Close files
  CLOSE DATASET source.
  CLOSE DATASET target.

* Delete source file if was wanted
  IF move EQ abap_true.
    DELETE DATASET source.
  ENDIF.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.4.3 - E.G.Mellodew. 1998-2017. Sap Release 731
