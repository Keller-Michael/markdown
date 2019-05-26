*&---------------------------------------------------------------------*
*& Report zmd_playground
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmd_playground.

WRITE | This is a { zcl_md_emphasis=>strong( 'strong' ) } emphasis. |.

" some headlines
DATA(header_level_1) = NEW zcl_md_header(
                         name       = 'HEADLINE 1'
                         level      = 1
                         text       = 'Headline on level 1'
                         underlined = abap_true ).

DATA(header_level_2) = NEW zcl_md_header(
                         name       = 'HEADLINE 2'
                         level      = 2
                         text       = 'Headline on level 2'
                         underlined = abap_true ).

" some paragraphs
DATA(paragraph_1) = NEW zcl_md_paragraph( 'Line by constructor' ).
DATA(paragraph_2) = NEW zcl_md_paragraph( ).
paragraph_2->add_line_with_break( 'Line with break').
paragraph_2->add_blank_line( ).

" some source code
"data(source_code) = new zcl_md_code( name = 'ABAP source code' )
 "                                    code = value( 'WRITE sy-datum.' 'WRITE sy-uname.' ) ).

" add headlines ... to document
DATA(document) = NEW zcl_md_document( ).
TRY.
    document->add( header_level_1 ).
    document->add( header_level_2 ).
    document->add( paragraph_1 ).
    document->add( paragraph_2 ).
  CATCH zcx_md_error.

ENDTRY.

DATA(output) = NEW zcl_md_output( document = document ).

output->write_to_screen( ).

output->copy_to_clipboard( ).
