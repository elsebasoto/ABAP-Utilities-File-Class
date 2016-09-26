**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD create_zip_file_app_svr.

  DATA: ol_zipper       TYPE REF TO cl_abap_zip.

  DATA: tl_file_data    TYPE STANDARD TABLE OF solisti1,
        tl_file_tab_zip TYPE STANDARD TABLE OF solisti1.

  DATA: wl_file         TYPE zbcsfiles.

  DATA: vl_bin_filesize TYPE i,
        vl_xstring_data TYPE xstring,
        vl_zip          TYPE xstring.

***
* 1.- Create ZIP file
***
  CREATE OBJECT ol_zipper.

***
* 2.- Each file to compress
***
  LOOP AT files INTO wl_file.

***
* 3.- Read the file
***
    CALL METHOD zcl_ca_file_utilities=>read_file
      EXPORTING
        file      = wl_file
      IMPORTING
        length    = vl_bin_filesize
        file_data = tl_file_data.


***
* 4.- Convert to XString
***
    CALL METHOD zcl_ca_file_utilities=>convert_bin_to_xstring
      EXPORTING
        length       = vl_bin_filesize
      CHANGING
        xstring_data = vl_xstring_data
        file_data    = tl_file_data.

****
** 5.- Add the file in the ZIP
****

    CALL METHOD zcl_ca_file_utilities=>add_file_to_zip
      EXPORTING
        xstring_data     = vl_xstring_data
        file_name_in_zip = wl_file-file_name_in_zip
      CHANGING
        zipper           = ol_zipper.

    AT LAST.

***
* 6.- Save the ZIP file
***

      CALL METHOD zcl_ca_file_utilities=>save_zip
        EXPORTING
          zipper       = ol_zipper
        IMPORTING
          zip          = vl_zip
        CHANGING
          file_tab_zip = tl_file_tab_zip.

***
* 7.- Download ZIP
***

      CALL METHOD zcl_ca_file_utilities=>download_zip_file
        EXPORTING
          filename     = zip_name
        IMPORTING
          file_tab_zip = tl_file_tab_zip.

    ENDAT.

  ENDLOOP.

  IF sy-subrc NE 0.
    MESSAGE e021(earc) RAISING files_is_initial.
*   No archive files exist that can be opened
  ENDIF.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
