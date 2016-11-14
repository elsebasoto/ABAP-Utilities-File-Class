**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD filesource_from_path.

  DATA: t_string      TYPE STANDARD TABLE OF string.

  DATA: vl_type       TYPE string,
        vl_reg_value  TYPE string,
        vl_key        TYPE string,
        vl_drive      TYPE string.

  IF path IS INITIAL OR STRLEN( path ) LE 1.
    RAISE path_error.
  ENDIF.

  real_path = path.
  vl_drive = path(2).

* Get the source drive type
  CALL METHOD cl_gui_frontend_services=>get_drive_type
    EXPORTING
      drive                = vl_drive
    CHANGING
      drive_type           = vl_type
    EXCEPTIONS
      cntl_error           = 1
      bad_parameter        = 2
      error_no_gui         = 3
      not_supported_by_gui = 4
      OTHERS               = 5.
  IF sy-subrc NE 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      cntl_system_error = 1
      cntl_error        = 2
      OTHERS            = 3.
  IF sy-subrc NE 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  drive = vl_type.

  CHECK path(2) NE '\\'.
  drive_unit = path(1).

* IF is a REMOTE conection, read the windows registry to know the destination
  CHECK vl_type EQ 'REMOTE'.

  CONCATENATE 'Network\' vl_drive(1) INTO vl_key.

  drive_unit = vl_drive(1).

  CALL METHOD cl_gui_frontend_services=>registry_get_value
    EXPORTING
      root                 = cl_gui_frontend_services=>hkey_current_user
      key                  = vl_key
      value                = 'RemotePath'
    IMPORTING
      reg_value            = vl_reg_value
    EXCEPTIONS
      get_regvalue_failed  = 1
      cntl_error           = 2
      error_no_gui         = 3
      not_supported_by_gui = 4
      OTHERS               = 5.

  IF sy-subrc NE 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  IF STRLEN( real_path ) GE 2.
    real_path = real_path+2.
  ENDIF.

  IF STRLEN( real_path ) GE 1 AND real_path(1) EQ '\'.
    real_path = real_path+1.
  ENDIF.

  CONCATENATE vl_reg_value real_path INTO real_path SEPARATED BY '\'.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
