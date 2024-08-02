(math_delimiter
  left_command: _ @conceal (#set! conceal ""))
(math_delimiter
  right_command: _ @conceal (#set! conceal ""))
(inline_formula ["$" "\\(" "\\)"] @conceal (#set! conceal ""))
(displayed_equation ["$$" "\\[" "\\]"] @conceal (#set! conceal ""))
(text_mode
  command: _ @conceal (#set! conceal ""))
