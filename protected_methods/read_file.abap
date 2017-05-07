**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Protected
**************************************************************************

METHOD read_file.

  DATA: wl_file_data TYPE solisti1,
        vl_length    TYPE i.

  CLEAR file_data.
  CLEAR length.

  OPEN DATASET file-file_name FOR INPUT IN BINARY MODE.
  IF sy-subrc EQ 0.
    DO.
      READ DATASET file-file_name INTO wl_file_data LENGTH vl_length.
      IF sy-subrc NE 0.
        IF vl_length GT 0.
          APPEND wl_file_data TO file_data.
          ADD vl_length TO length.
        ENDIF.
        EXIT.
      ELSE.
        APPEND wl_file_data TO file_data.
        ADD vl_length TO length.
      ENDIF.
    ENDDO.
  ELSE.
    MESSAGE i012(ba) WITH file-file_name.
*   Cannot open archive file &
  ENDIF.

  CLOSE DATASET file-file_name.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.4.3 - E.G.Mellodew. 1998-2017. Sap Release 731
