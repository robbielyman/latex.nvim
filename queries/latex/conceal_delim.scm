; (curly_group "{" @conceal
;   (#not-has-grandparent? @conceal title_declaration author_declaration chapter part section subsection subsubsection paragraph subparagraph generic_command)
;   (#set! conceal ""))
; (curly_group "}" @conceal
;   (#not-has-grandparent? @conceal title_declaration author_declaration chapter part section subsection subsubsection paragraph subparagraph generic_command)
;   (#set! conceal ""))
(math_delimiter
  left_command: _ @conceal (#set! conceal ""))
(math_delimiter
  right_command: _ @conceal (#set! conceal ""))
(inline_formula "$" @conceal (#set! conceal ""))
(inline_formula "\\(" @conceal (#set! conceal ""))
(inline_formula "\\)" @conceal (#set! conceal ""))
(displayed_equation "\\[" @conceal (#set! conceal ""))
(displayed_equation "\\]" @conceal (#set! conceal ""))
(displayed_equation "$$" @conceal (#set! conceal ""))
(text_mode
  command: _ @conceal (#set! conceal ""))
("\\item" @punctuation.special @conceal (#set! conceal "○"))
