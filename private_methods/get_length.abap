**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Private
**************************************************************************

METHOD get_length.

  DATA: lo_data TYPE REF TO cl_abap_elemdescr.

  lo_data ?= cl_abap_elemdescr=>describe_by_data( input ).

  IF output_format EQ abap_true.
    length = lo_data->output_length.
    RETURN.
  ENDIF.

  length = lo_data->decimals + lo_data->length.

  CASE lo_data->type_kind.
    WHEN lo_data->typekind_packed.
      ADD 1 TO length.

    WHEN OTHERS.
  ENDCASE.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2018. Sap Release 731
