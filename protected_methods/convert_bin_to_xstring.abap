**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Protected
**************************************************************************

METHOD convert_bin_to_xstring.

  CLEAR xstring_data.

  CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
    EXPORTING
      input_length = length
    IMPORTING
      buffer       = xstring_data
    TABLES
      binary_tab   = file_data.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.4.3 - E.G.Mellodew. 1998-2017. Sap Release 731
