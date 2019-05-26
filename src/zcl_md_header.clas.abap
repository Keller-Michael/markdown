CLASS zcl_md_header DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES content_table TYPE TABLE OF string WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        name       TYPE string OPTIONAL
        level      TYPE i OPTIONAL
        text       TYPE string
        underlined TYPE abap_bool OPTIONAL
      RAISING
        zcx_md_error.

    METHODS get_content RETURNING VALUE(result) TYPE content_table.

    METHODS get_name RETURNING VALUE(result) TYPE string.

    METHODS get_level RETURNING VALUE(result) TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: name    TYPE string,
          level   TYPE i,
          content TYPE content_table.

    METHODS change_text IMPORTING text TYPE string.

    METHODS add_bar
      RAISING
        zcx_md_error.
ENDCLASS.



CLASS zcl_md_header IMPLEMENTATION.
  METHOD constructor.
    DATA: line TYPE string,
          bar  TYPE string.

    IF name IS NOT INITIAL.
      me->name = name.
    ELSE.
      me->name = '<DUMMY>'.
    ENDIF.

    IF level IS NOT INITIAL.
      me->level = level.
    ELSE.
      me->level = 1.
    ENDIF.

    IF text IS INITIAL.
      RAISE EXCEPTION TYPE zcx_md_error EXPORTING code = zcx_md_error=>code_enum-bad_method_parameters.
    ENDIF.

    change_text( text = text ).

    IF underlined = abap_true.
      add_bar( ).
    ENDIF.
  ENDMETHOD.

  METHOD get_content.
    result = content.
  ENDMETHOD.

  METHOD get_level.
    result = level.
  ENDMETHOD.

  METHOD get_name.
    result = name.
  ENDMETHOD.

  METHOD add_bar.
    DATA bar TYPE string.

    TRY.
        DATA(headline) = content[ 1 ].
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_md_error EXPORTING code = zcx_md_error=>code_enum-table_line_not_found.
    ENDTRY.

    DO strlen( headline ) TIMES.
      bar = |{ bar }-|.
    ENDDO.

    IF bar IS NOT INITIAL.
      APPEND bar TO content.
    ENDIF.
  ENDMETHOD.

  METHOD change_text.
    DATA headline TYPE string.

    DO level TIMES.
      headline = |{ headline }#|.
    ENDDO.

    headline = |{ headline } { text }|.

    APPEND headline TO content.
  ENDMETHOD.

ENDCLASS.
