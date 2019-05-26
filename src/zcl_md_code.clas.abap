CLASS zcl_md_code DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES content_table TYPE TABLE OF string WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        name TYPE string
        code TYPE content_table.

    CLASS-METHODS convert_for_inline_use IMPORTING text TYPE string RETURNING VALUE(result) TYPE string.

    METHODS get_content
      RETURNING
        VALUE(result) TYPE content_table
      RAISING
        zcx_md_error.

    METHODS get_name RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: name    TYPE string,
          content TYPE content_table.
ENDCLASS.



CLASS zcl_md_code IMPLEMENTATION.
  METHOD convert_for_inline_use.
    result = |`{ text }`|.
  ENDMETHOD.

  METHOD constructor.
    me->name = name.
    content = code.
  ENDMETHOD.

  METHOD get_content.
    CONSTANTS code_block_sign TYPE string VALUE '```'.

    IF content IS INITIAL.
      RAISE EXCEPTION TYPE zcx_md_error EXPORTING code = zcx_md_error=>code_enum-no_content.
    ENDIF.

    APPEND code_block_sign TO result.
    APPEND LINES OF content TO result.
    APPEND code_block_sign TO result.
  ENDMETHOD.

  METHOD get_name.
    result = name.
  ENDMETHOD.
ENDCLASS.
