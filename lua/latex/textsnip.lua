local M = {}
M.cmd2char = {}
M.cmd3char = {
  sec = [[\section{<>}]],
  cha = [[\chapter{<>}]],
  sse = [[\subsection{<>}]],
  sss = [[\subsubsection{<>}]],
  iee = [[i.e., ]],
  stt = [[such that ]],
  iff = [[if and only if ]],
  udl = [[\underline{<>}]],
}
local cmd3charwithcom = {}
M.cmd4char = {
  cite = [[\cite{<>}]],
  href = [[\href{<>}{<>}]],
  wlog = [[without loss of generality ]],
  Wlog = [[Without loss of generality ]],
}
local cmd4charwithcom = {}
for k, v in pairs(cmd3charwithcom) do
  local k1 = string.gsub(k, "%(%%a%)", "%%s")
  for i = string.byte("a"), string.byte("z") do
    local c = string.char(i)
    local cmd = string.format(k1, c)
    if M.cmd3char[cmd] then
      print("there is conflict in snip " .. cmd .. "with" .. M.cmd3char[cmd] .. " and " .. string.gsub(cmd, k, v))
    end
    M.cmd3char[cmd] = string.gsub(cmd, k, v)
  end
  for i = string.byte("A"), string.byte("Z") do
    local c = string.char(i)
    local cmd = string.format(k1, c)
    if M.cmd3char[cmd] then
      print("there is conflict in snip " .. cmd .. "with" .. M.cmd3char[cmd] .. " and " .. string.gsub(cmd, k, v))
    end
    M.cmd3char[cmd] = string.gsub(cmd, k, v)
  end
end
for k, v in pairs(cmd4charwithcom) do
  local k1 = string.gsub(k, "%(%%a%)", "%%s")
  for i = string.byte("a"), string.byte("z") do
    local c = string.char(i)
    local cmd = string.format(k1, c)
    if M.cmd4char[cmd] then
      print("there is conflict in snip " .. cmd .. "with" .. M.cmd4char[cmd] .. " and " .. string.gsub(cmd, k, v))
    end
    M.cmd4char[cmd] = string.gsub(cmd, k, v)
  end
  for i = string.byte("A"), string.byte("Z") do
    local c = string.char(i)
    local cmd = string.format(k1, c)
    if M.cmd4char[cmd] then
      print("there is conflict in snip " .. cmd .. "with" .. M.cmd4char[cmd] .. " and " .. string.gsub(cmd, k, v))
    end
    M.cmd4char[cmd] = string.gsub(cmd, k, v)
  end
end
M.solveConflict = {}
local conflictNum = 0
for k, v in pairs(M.cmd4char) do
  local last = string.sub(k, -1, -1)
  k = string.sub(k, 1, 3)
  local cmd3 = M.cmd3char[k]
  if cmd3 then
    if string.match(cmd3, "<>") then
      print("there is conflict in snip " .. k .. "=" .. cmd3 .. " and " .. k .. last .. "=" .. v)
    end
    M.solveConflict[cmd3 .. last] = v
    conflictNum = conflictNum + 1
  end
  last = string.sub(k, -1, -1) .. last
  k = string.sub(k, 1, 2)
  local cmd2 = M.cmd2char[k]
  if cmd2 then
    if string.match(cmd2, "<>") then
      print("there is conflict in snip " .. k .. "=" .. cmd2 .. " and " .. k .. last .. "=" .. v)
    end
    M.solveConflict[cmd2 .. last] = v
    conflictNum = conflictNum + 1
  end
end
for k, v in pairs(M.cmd3char) do
  local last = string.sub(k, -1, -1)
  k = string.sub(k, 1, 2)
  local cmd2 = M.cmd2char[k]
  if cmd2 then
    if string.match(cmd2, "<>") then
      print("there is conflict in snip " .. k .. "=" .. cmd2 .. " and " .. k .. last .. "=" .. v)
    end
    M.solveConflict[cmd2 .. last] = v
    conflictNum = conflictNum + 1
  end
end
M.conflictNum = conflictNum
return M
