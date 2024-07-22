; greek conceal
(generic_command
  command: ((command_name) @mathgreek
  (#conceal-table? @mathgreek "greek"))
  (#has-ancestor? @mathgreek math_environment inline_formula displayed_equation)
  (#not-has-ancestor? @mathgreek label_definition text_mode)
  (#latexconceal! @mathgreek "greek"))
