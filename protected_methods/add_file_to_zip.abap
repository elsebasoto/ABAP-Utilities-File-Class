**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Protected
**************************************************************************

METHOD add_file_to_zip.

  DATA: vl_file_name TYPE string.

  vl_file_name = file_name_in_zip.

* Add the file into the ZIP
  CALL METHOD zipper->add
    EXPORTING
      name    = vl_file_name
      content = xstring_data.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.4.3 - E.G.Mellodew. 1998-2017. Sap Release 731
