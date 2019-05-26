CLASS zcl_md_compiler DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES markdown_document_table TYPE TABLE OF string WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        document TYPE REF TO zcl_md_document.

    METHODS run
      RETURNING
        VALUE(result) TYPE markdown_document_table
      RAISING
        zcx_md_error.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: raw_document      TYPE REF TO zcl_md_document,
          markdown_document TYPE markdown_document_table.
ENDCLASS.



CLASS zcl_md_compiler IMPLEMENTATION.
  METHOD run.
    DATA: header    TYPE REF TO zcl_md_header,
          paragraph TYPE REF TO zcl_md_paragraph.

    DATA: content TYPE TABLE OF string.

    CLEAR markdown_document.

    DATA(parts) = raw_document->get_parts( ).

    LOOP AT parts ASSIGNING FIELD-SYMBOL(<part>).
      CLEAR content.

      CASE <part>-type.
        WHEN 'ZCL_MD_HEADER'.
          header ?= <part>-object.
          content = header->get_content( ).

        WHEN 'ZCL_MD_PARAGRAPH'.
          paragraph ?= <part>-object.
          content = paragraph->get_content( ).

        WHEN OTHERS.
          RAISE EXCEPTION TYPE zcx_md_error EXPORTING code = zcx_md_error=>code_enum-part_type_unkown.
      ENDCASE.

      IF content IS NOT INITIAL.
        APPEND LINES OF content TO markdown_document.
      ENDIF.
    ENDLOOP.

    result = markdown_document.
  ENDMETHOD.

  METHOD constructor.
    raw_document = document.
  ENDMETHOD.

ENDCLASS.
