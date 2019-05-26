CLASS zcl_md_output DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        document TYPE REF TO zcl_md_document.

    METHODS write_to_screen.

    METHODS copy_to_clipboard.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: document TYPE REF TO zcl_md_document,
          compiler TYPE REF TO zcl_md_compiler.
ENDCLASS.



CLASS zcl_md_output IMPLEMENTATION.
  METHOD constructor.
    me->document = document.
    compiler = NEW zcl_md_compiler( document = document ).
  ENDMETHOD.

  METHOD write_to_screen.
    TRY.
        DATA(result) = compiler->run( ).
      CATCH zcx_md_error.
    ENDTRY.

    LOOP AT result INTO DATA(line).
      WRITE / line.
    ENDLOOP.
  ENDMETHOD.

  METHOD copy_to_clipboard.
    DATA: rc        TYPE i,
          data      TYPE TABLE OF text1024,
          data_line LIKE LINE OF data.

    TRY.
        DATA(result) = compiler->run( ).
      CATCH zcx_md_error.
        RETURN.
    ENDTRY.
    LOOP AT result INTO DATA(line).
      data_line = line.
      APPEND data_line TO data.
    ENDLOOP.

    cl_gui_frontend_services=>clipboard_export(
      EXPORTING
        no_auth_check        = space
      IMPORTING
        data                 = data
      CHANGING
        rc                   = rc
      EXCEPTIONS
        cntl_error           = 1
        error_no_gui         = 2
        not_supported_by_gui = 3
        no_authority         = 4
        OTHERS               = 5 ).

    IF sy-subrc <> 0.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
