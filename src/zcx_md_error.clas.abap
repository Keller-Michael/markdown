CLASS zcx_md_error DEFINITION PUBLIC INHERITING FROM cx_static_check FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES code_type TYPE i.

    CONSTANTS:
      BEGIN OF code_enum,
        bad_method_parameters TYPE code_type VALUE 1,
        table_line_not_found  TYPE code_type VALUE 2,
        part_type_unkown      TYPE code_type VALUE 3,
        no_content            type code_type value 4,
      END OF code_enum.

    DATA code TYPE code_type.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !code     TYPE code_type OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_md_error IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
