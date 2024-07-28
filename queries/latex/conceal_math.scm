; math conceals
(generic_command
  command: ((command_name) @operator
  (#conceal-table? @operator "operator")
  (#latexconceal! @operator "operator")))
(generic_command
  command: ((command_name) @relationship
  (#conceal-table? @relationship "relationship")
  (#latexconceal! @relationship "relationship")))
(generic_command
  command: ((command_name) @others
  (#conceal-table? @others "others")
  (#latexconceal! @others "others")))
