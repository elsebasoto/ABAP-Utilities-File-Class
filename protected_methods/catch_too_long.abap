**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Protected
**************************************************************************

METHOD catch_too_long.

  TRY.

*     Try with 1 less length
      length  = length - 1.
      field = input+aggregate(length).

    CATCH cx_sy_range_out_of_bounds.

*     Try again
      CALL METHOD zcl_ca_file_utilities=>catch_too_long
        EXPORTING
          input     = input
          aggregate = aggregate
        CHANGING
          length    = length
          field     = field.

  ENDTRY.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
