; superscripts and subscripts conceals
(text
  word: (subscript) @script
  (#has-ancestor? @script math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @script text_mode label_definition)
  (#conceal-table? @script "subscript")
  (#latexconceal! @script "subscript"))

(text
  word: (subscript) @script
  (#has-ancestor? @script math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @script text_mode label_definition)
  (#conceal-table? @script "superscript")
  (#latexconceal! @script "superscript"))
