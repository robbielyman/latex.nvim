(curly_group "{" @conceal 
  (#not-has-grandparent? @conceal section subsection title_declaration generic_command paragraph)
  (#set! conceal ""))
(curly_group "}" @conceal 
  (#not-has-grandparent? @conceal section subsection title_declaration generic_command paragraph)
  (#set! conceal ""))
(math_delimiter
  left_command: _ @conceal (#set! conceal ""))
(math_delimiter
  right_command: _ @conceal (#set! conceal ""))
(inline_formula "$" @conceal (#set! conceal ""))
(displayed_equation "\\[" @conceal (#set! conceal ""))
(displayed_equation "\\]" @conceal (#set! conceal ""))
(text_mode 
  command: "\\text" @conceal (#set! conceal ""))
