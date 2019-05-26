CLASS zcl_md_paragraph DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES content_table TYPE TABLE OF string WITH EMPTY KEY.

    METHODS add_line
      IMPORTING
        text TYPE string.

    METHODS add_line_with_break
      IMPORTING
        text TYPE string.

    METHODS add_blank_line.

    METHODS constructor
      IMPORTING
        name       TYPE string OPTIONAL
        text       TYPE string OPTIONAL
        with_break TYPE abap_bool OPTIONAL
          PREFERRED PARAMETER text.

    METHODS get_content RETURNING VALUE(result) TYPE content_table.

    METHODS get_name RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: name    TYPE string,
          content TYPE content_table.
ENDCLASS.



CLASS zcl_md_paragraph IMPLEMENTATION.
  METHOD add_line.
    APPEND text TO content.
  ENDMETHOD.

  METHOD add_line_with_break.
    DATA(new_line) = |{ text }{ cl_abap_char_utilities=>cr_lf }|.
    APPEND new_line TO content.
  ENDMETHOD.

  METHOD add_blank_line.
    DATA(new_line) = space.
    APPEND new_line TO content.
  ENDMETHOD.

  METHOD constructor.
    IF name IS NOT INITIAL.
      me->name = name.
    ELSE.
      me->name = '<DUMMY>'.
    ENDIF.

    IF with_break = abap_true.
      add_line_with_break( text ).
    ELSE.
      add_line( text ).
    ENDIF.
  ENDMETHOD.

  METHOD get_content.
    result = content.
  ENDMETHOD.

  METHOD get_name.
    result = name.
  ENDMETHOD.

ENDCLASS.
