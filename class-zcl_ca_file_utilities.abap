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

  class-methods CREATE_ZIP_FILE_APP_SVR
    importing
      ZIP_NAME type ESEFTAPPL
      FILES type ZBCTPFILES
    exceptions
      FILES_IS_INITIAL .

**************************************************************************
*   Private section of class.                                            *
**************************************************************************
*"* private components of class ZCL_CA_FILE_UTILITIES
*"* do not include other source files here!!
private section.

**************************************************************************
*   Protected section of class.                                          *
**************************************************************************
*"* protected components of class ZCL_CA_FILE_UTILITIES
*"* do not include other source files here!!
protected section.

  class-methods READ_FILE
    importing
      FILE type ZBCSFILES
    exporting
      LENGTH type I
      FILE_DATA type SWFTLISTI1 .
  class-methods CONVERT_BIN_TO_XSTRING
    importing
      LENGTH type I
    changing
      XSTRING_DATA type XSTRING
      FILE_DATA type SWFTLISTI1 .
  class-methods ADD_FILE_TO_ZIP
    importing
      XSTRING_DATA type XSTRING
      FILE_NAME_IN_ZIP type ZBCSFILES-FILE_NAME_IN_ZIP
    changing
      value(ZIPPER) type ref to CL_ABAP_ZIP .
  class-methods SAVE_ZIP
    importing
      ZIPPER type ref to CL_ABAP_ZIP
    exporting
      ZIP type XSTRING
    changing
      FILE_TAB_ZIP type SWFTLISTI1 .
  class-methods DOWNLOAD_ZIP_FILE
    importing
      FILENAME type ESEFTAPPL
    exporting
      FILE_TAB_ZIP type SWFTLISTI1 .

**************************************************************************
*   Types section of class.                                              *
**************************************************************************
*"* dummy include to reduce generation dependencies between
*"* class ZCL_CA_FILE_UTILITIES and it's users.
*"* touched if any type reference has been changed


*Messages
*----------------------------------------------------------
*
* Message class: BA
*012   Cannot open archive file &
*
* Message class: EARC
*021   No archive files exist that can be opened

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700