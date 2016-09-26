**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Protected
**************************************************************************

METHOD save_zip.

  DATA: vl_bin_filesize TYPE i.

* Save the ZIP
  CALL METHOD zipper->save
    RECEIVING
      zip = zip.

* Create the binary file
  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer        = zip
    IMPORTING
      output_length = vl_bin_filesize
    TABLES
      binary_tab    = file_tab_zip.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
