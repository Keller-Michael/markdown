" test with Gitpod, written without system

interface zif_markdown_doc.
	methods add_headline_level_1
        importing
            iv_chapter type string.

	methods add_headline_level_2
        importing
            iv_chapter type string.

	methods add_headline_level_3
        importing
            iv_chapter type string.

	methods add_line
		importing
			iv_chapter type string optional
			iv_note	  type string optional.

	methods add_line_break
		importing
			iv_chapter type string optional.

    methods clear.

	methods clear.
endinterface.



class zcl_markdown_doc definition public final create public.
	public section.
		interfaces zif_markdown_doc.

	private section.
		types: begin of content,
					chapter type string,
					text type string,
					note type string,
			    end of content.

	method add_line.
	endmethod.

	method add_line_break.
	endmethod.

endclass.


class zcl_markdown_doc implementation.


endclass.