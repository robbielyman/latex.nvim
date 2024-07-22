(generic_command
  command: (command_name) @conceal
  (#any-of? @conceal "\\emph" "\\mathit" "\\textit" "\\mathbf" "\\textbf")
  (#set! conceal ""))

((generic_command
   command: (command_name)
   arg: (curly_group)) @mathfont
 (#conceal-table? @mathfont "mathfont" )
 (#latexconceal! @mathfont "mathfont"))
