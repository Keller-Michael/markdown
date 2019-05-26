CLASS zcl_md_emphasis DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS strong importing text TYPE string RETURNING VALUE(result) type string.

    CLASS-METHODS italic importing text TYPE string RETURNING VALUE(result) type string.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_md_emphasis IMPLEMENTATION.
  METHOD strong.
    result = |**{ text }**|.
  ENDMETHOD.

  METHOD italic.
    result = |*{ text }*|.
  ENDMETHOD.
ENDCLASS.
