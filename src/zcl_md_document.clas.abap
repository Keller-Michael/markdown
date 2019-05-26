CLASS zcl_md_document DEFINITION PUBLIC FINAL CREATE PUBLIC GLOBAL FRIENDS zcl_md_compiler.
  PUBLIC SECTION.
    TYPES: BEGIN OF part_line,
             name   TYPE string,
             type   TYPE string,
             object TYPE REF TO object,
           END OF part_line.

    TYPES parts_table TYPE TABLE OF part_line WITH EMPTY KEY.

    METHODS add
      IMPORTING part TYPE REF TO object
      RAISING
                zcx_md_error.

  PROTECTED SECTION.
    METHODS get_parts
      RETURNING VALUE(result) TYPE parts_table.

  PRIVATE SECTION.
    DATA parts_list TYPE parts_table.
ENDCLASS.



CLASS zcl_md_document IMPLEMENTATION.
  METHOD add.
    DATA: part_line TYPE part_line,
          header    TYPE REF TO zcl_md_header,
          paragraph TYPE REF TO zcl_md_paragraph.

    DATA(class_description) = CAST cl_abap_classdescr( cl_abap_typedescr=>describe_by_object_ref( part ) ).
    part_line-type = class_description->absolute_name.
    REPLACE FIRST OCCURRENCE OF '\CLASS=' IN part_line-type WITH space.

    CASE part_line-type.
      WHEN 'ZCL_MD_HEADER'.
        header ?= part.
        part_line-name = header->get_name( ).

      WHEN 'ZCL_MD_PARAGRAPH'.
        paragraph ?= part.
        part_line-name = paragraph->get_name( ).

      WHEN OTHERS.
        RAISE EXCEPTION TYPE zcx_md_error EXPORTING code = zcx_md_error=>code_enum-part_type_unkown.
    ENDCASE.

    IF part_line IS NOT INITIAL.
      part_line-object = part.
      APPEND part_line TO parts_list.
    ENDIF.
  ENDMETHOD.

  METHOD get_parts.
    result = parts_list.
  ENDMETHOD.
ENDCLASS.
