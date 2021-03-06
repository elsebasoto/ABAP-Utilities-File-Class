**************************************************************************
*   Class attributes.                                                    *
**************************************************************************
Instantiation: Public
Message class:
State: Implemented
Final Indicator: X
R/3 Release: 700

**************************************************************************
*   Public section of class.                                             *
**************************************************************************
class ZCL_CA_FILE_UTILITIES definition
  public
  final
  create public .

*"* public components of class ZCL_CA_FILE_UTILITIES
*"* do not include other source files here!!
public section.

  types:
    BEGIN OF ty_otf,
             copies TYPE num,
             otf    TYPE tsfotf,
           END OF ty_otf .
  types:
    ty_t_otf TYPE STANDARD TABLE OF ty_otf .

  class-methods CALCULATE_FILE_SIZE
    importing
      TYPE type CHAR10 default 'ASC'
      DATA type ANY TABLE
    preferred parameter TYPE
    returning
      value(SIZE) type I
    exceptions
      FORMAT_NOT_SUPPORTED .
  class-methods CREATE_ZIP_FILE_APP_SVR
    importing
      ZIP_NAME type ESEFTAPPL
      FILES type ZBCTPFILES
    exceptions
      FILES_IS_INITIAL .
  class-methods FILESOURCE_FROM_PATH
    importing
      PATH type STRING
    exporting
      DRIVE type STRING
      DRIVE_UNIT type STRING
      REAL_PATH type STRING
    exceptions
      PATH_ERROR .
  class-methods FIXEDTAB_TO_STANDARDTAB
    importing
      INPUT type STRINGTAB
      LENGTHS type INT4_TABLE
    exporting
      OUTPUT type STANDARD TABLE
    exceptions
      ASSIGN_ERROR .
  class-methods FIXEDTAB_TO_STANDARDTAB_2
    importing
      INPUT type STRINGTAB
    exporting
      OUTPUT type STANDARD TABLE .
  class-methods GET_FILE_SEPARATOR
    importing
      BATCH type SY-BATCH optional
    changing
      value(FILE_SEPARATOR) type C
    exceptions
      NOT_SUPPORTED_BY_GUI
      ERROR_NO_GUI
      CNTL_ERROR .
  class-methods MERGE_OTF_INTO_1_PDF
    importing
      OTF_TABS type TY_T_OTF
    exporting
      PDF type XSTRING
      FILESIZE type SO_OBJ_LEN .
  type-pools ABAP .
  class CL_ABAP_CHAR_UTILITIES definition load .
  class-methods STANDARDTAB_TO_STRINGTAB
    importing
      INPUT type ANY TABLE
      SPLITTER type ABAP_CHAR1 default CL_ABAP_CHAR_UTILITIES=>HORIZONTAL_TAB
      ENCLOSED type ABAP_CHAR1 default ''
      DECIMALS_FLOAT type QSTELLEN default 0
    exporting
      OUTPUT type STRINGTAB .
  class-methods STRINGTAB_TO_STANDARDTAB
    importing
      INPUT type STRINGTAB
      SPLIT type ABAP_CHAR1 default CL_ABAP_CHAR_UTILITIES=>HORIZONTAL_TAB
    exporting
      value(OUTPUT) type STANDARD TABLE
    exceptions
      ASSIGN_ERROR .
  class-methods ARCHIVFILE_SERVER_TO_SERVER
    importing
      SOURCE type ZBCDE0026
      TARGET type ZBCDE0027
      MOVE type ABAP_BOOL default ''
    raising
      CX_T100_MSG
      CX_SY_FILE_OPEN
      CX_SY_CODEPAGE_CONVERTER_INIT
      CX_SY_CONVERSION_CODEPAGE
      CX_SY_FILE_AUTHORITY
      CX_SY_FILE_IO
      CX_SY_FILE_OPEN_MODE
      CX_SY_FILE_CLOSE .
  class-methods ARCHIVFILE_CLIENT_TO_SERVER
    importing
      SOURCE type ZBCDE0026
      TARGET type ZBCDE0027
      MOVE type ABAP_BOOL default ''
    raising
      CX_T100_MSG
      CX_SY_FILE_OPEN
      CX_SY_CODEPAGE_CONVERTER_INIT
      CX_SY_CONVERSION_CODEPAGE
      CX_SY_FILE_AUTHORITY
      CX_SY_FILE_IO
      CX_SY_FILE_OPEN_MODE
      CX_SY_FILE_CLOSE .
  class-methods CONVERT_GENERIC_TO_STRING
    importing
      INPUT type ANY
      OUTPUT_FORMAT type BOOLEAN default ''
    returning
      value(OUTPUT) type STRING .

**************************************************************************
*   Private section of class.                                            *
**************************************************************************
*"* private components of class ZCL_CA_FILE_UTILITIES
*"* do not include other source files here!!
private section.

  class-methods GET_LENGTH
    importing
      INPUT type ANY
      OUTPUT_FORMAT type BOOLEAN default ''
    returning
      value(LENGTH) type I .

**************************************************************************
*   Protected section of class.                                          *
**************************************************************************
*"* protected components of class ZCL_CA_FILE_UTILITIES
*"* do not include other source files here!!
protected section.

  class-methods ADD_FILE_TO_ZIP
    importing
      XSTRING_DATA type XSTRING
      FILE_NAME_IN_ZIP type ZBCSFILES-FILE_NAME_IN_ZIP
    changing
      value(ZIPPER) type ref to CL_ABAP_ZIP .
  class-methods CATCH_TOO_LONG
    importing
      INPUT type STRING
      AGGREGATE type I
    changing
      LENGTH type I
      FIELD type ANY .
  class-methods CONVERT_BIN_TO_XSTRING
    importing
      LENGTH type I
    changing
      XSTRING_DATA type XSTRING
      FILE_DATA type SWFTLISTI1 .
  class-methods DOWNLOAD_ZIP_FILE
    importing
      FILENAME type ESEFTAPPL
    exporting
      FILE_TAB_ZIP type SWFTLISTI1 .
  class-methods READ_FILE
    importing
      FILE type ZBCSFILES
    exporting
      LENGTH type I
      FILE_DATA type SWFTLISTI1 .
  class-methods SAVE_ZIP
    importing
      ZIPPER type ref to CL_ABAP_ZIP
    exporting
      ZIP type XSTRING
    changing
      FILE_TAB_ZIP type SWFTLISTI1 .

**************************************************************************
*   Types section of class.                                              *
**************************************************************************
*"* dummy include to reduce generation dependencies between
*"* class ZCL_CA_FILE_UTILITIES and it's users.
*"* touched if any type reference has been changed

*Text elements
*----------------------------------------------------------
* E01 Error opening source file
* E02 Error opening destination file


*Messages
*----------------------------------------------------------
*
* Message class: AFWBM_MAIN
*036   Internal error in the tool for assigning characteristic values
*
* Message class: BA
*012   Cannot open archive file &
*
* Message class: EARC
*021   No archive files exist that can be opened
*
* Message class: SAPLWSPO
*011   Error in assignment of field symbol &1 in &2
*
* Message class: TD
*873   Format & not supported

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2018. Sap Release 700
