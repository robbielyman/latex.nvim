local sn=require("luasnip").SN
local M = {}
M.cmd2char = {
  ["ot"] = [[\leftarrow]],
  ["ad"] = [[+]],
  ["mn"] = [[-]],
  ["pm"] = [[\pm]],
  ["mp"] = [[\mp]],
  ["in"] = [[\in]],
  ["xx"] = [[\times]],
  ["to"] = [[\to]],
  ["Mu"] = [[\Mu]],
  ["mu"] = [[\mu]],
  ["Nu"] = [[\Nu]],
  ["nu"] = [[\nu]],
  ["Pi"] = [[\Pi]],
  ["pi"] = [[\pi]],
  ["Xi"] = [[\Xi]],
  ["xi"] = [[\xi]],
  ["or"] = [[\OR]],
  ["aa"] = [[\forall]],
  ["ee"] = [[\exists]],
  ["dd"] = [[\d]],
  ["ln"] = [[\ln]],
}
M.cmd3char = {
  ["prf"] = [[\vdash]],
  ["ind"] = [[\ind]],
  ["pto"] = [[\overset{\mathbb{P}}{\to}]],
  ["oto"] = [[\leftrightarrow]],
  ["sta"] = [[^{*}]],
  ["neg"] = [[\neg]],
  ["lms"] = [[\limsup]],
  ["lmi"] = [[\liminf]],
  ["cob"] = [[\binom{<>}{<>}]],
  ["vec"] = [[\vec{<>}]],
  ["abs"] = [[|<>|]],
  ["dot"] = [[\dot{<>}]],
  ["tdl"] = [[\tidle{<>}]],
  ["hat"] = [[\hat{<>}]],
  ["fun"] = [[\fun{<>}{<>}]],
  ["bar"] = [[\overline{<>}]],
  ["udl"] = [[\underline{<>}]],
  ["res"] = [[\res{<>}{<>}]],
  ["bor"] = [[\bigvee]],
  ["int"] = [[\int]],
  ["sum"] = [[\sum]],
  ["Zet"] = [[\Zeta]],
  ["zet"] = [[\zeta]],
  ["Psi"] = [[\Psi]],
  ["psi"] = [[\psi]],
  ["Rho"] = [[\Rho]],
  ["rho"] = [[\rho]],
  ["Sig"] = [[\Sigma]],
  ["sig"] = [[\sigma]],
  ["Tau"] = [[\Tau]],
  ["tau"] = [[\tau]],
  ["The"] = [[\Theta]],
  ["the"] = [[\theta]],
  ["vhi"] = [[\varphi]],
  ["Ome"] = [[\Omega]],
  ["ome"] = [[\omega]],
  ["omi"] = [[\omicron]],
  ["Phi"] = [[\Phi]],
  ["phi"] = [[\phi]],
  ["ale"] = [[\aleph]],
  ["alp"] = [[\alpha]],
  ["bet"] = [[\beta]],
  ["chi"] = [[\chi]],
  ["Del"] = [[\Delta]],
  ["del"] = [[\delta]],
  ["Eps"] = [[\Epsilon]],
  ["eps"] = [[\varepsilon]],
  ["Eta"] = [[\Eta]],
  ["eta"] = [[\eta]],
  ["Gam"] = [[\Gamma]],
  ["gam"] = [[\gamma]],
  ["Iot"] = [[\Iota]],
  ["iot"] = [[\iota]],
  ["Kap"] = [[\Kappa]],
  ["kap"] = [[\kappa]],
  ["Lam"] = [[\Lambda]],
  ["lam"] = [[\lambda]],
  ["and"] = [[\AND]],
  ["iff"] = [[\iff]],
  ["nin"] = [[\notin]],
  ["neq"] = [[\neq]],
  ["leq"] = [[\leq]],
  ["geq"] = [[\geq]],
  ["apx"] = [[\approx]],
  ["sim"] = [[\sim]],
  ["mto"] = [[\mapsto]],
  ["ker"] = [[\ker]],
  ["smn"] = [[\setminus]],
  ["mid"] = [[\mid]],
  ["rhs"] = [[\mathrm{R.H.S}]],
  ["lhs"] = [[\mathrm{L.H.S}]],
  ["cap"] = [[\cap]],
  ["cup"] = [[\cup]],
  ["sub"] = [[\subset]],
  ["ple"] = [[\prec]],
  ["ifn"] = [[\infty]],
  ["llr"] = [[\longleftrightarrow]],
  ["iso"] = [[\cong]],
  ["eqv"] = [[\equiv]],
  ["oti"] = [[\otimes]],
  ["opl"] = [[\oplus]],
  ["oad"] = [[\oplus]],
  ["not"] = [[\not]],
  ["par"] = [[\partial]],
  ["hom"] = [[\hom]],
  ["dim"] = [[\dim]],
  ["arg"] = [[\arg]],
  ["set"] = [[\set]],
  ["ord"] = [[\ord]],
  ["sin"] = [[\sin]],
  ["cos"] = [[\cos]],
  ["tan"] = [[\tan]],
  ["cot"] = [[\cot]],
  ["csc"] = [[\csc]],
  ["sec"] = [[\sec]],
  ["log"] = [[\log]],
  ["max"] = [[\max]],
  ["min"] = [[\min]],
  ["exp"] = [[\exp]],
  ["mod"] = [[\mod]],
  ["sgn"] = [[\sgn]],
  ["gcd"] = [[\gcd]],
  ["lcm"] = [[\lcm]],
  ["deg"] = [[\deg]],
  ["lim"] = [[\lim]],
  ["sup"] = [[\sup]],
  ["inf"] = [[\inf]],
  ["dom"] = [[\dom]],
  ["ran"] = [[\ran]],
  ["img"] = [[\im]],
  ["rel"] = [[\re]],
  ["dto"] = [[\overset{d}{\to}]],
  ["deq"] = [[\overset{d}{=}]],
  ["det"] = [[\det]],
  ["tra"] = [[\trace]],
  ["lgd"] = [[\legendre{<>}{<>}]],
}
local cmd3charwithcom = {
  ["bb(%a)"] = function(char)
    return [[\mathbb{]] .. string.upper(char) .. "}"
  end,
  ["bm(%a)"] = function(char)
    return [[\mathbbm{]] .. string.upper(char) .. "}"
  end,
  ["bf(%a)"] = [[\mathbf{%1}]],
  ["rm(%a)"] = [[\mathrm{%1}]],
  ["fk(%a)"] = [[\mathfrak{%1}]],
  ["te(%a)"] = [[\text{%1}]],
  ["(%a)tr"] = [[%1^{\mathsf{T}}]],
}
M.cmd4char = {
  ["pmat"] = [[pmat]], --for matrix.lua
  ["aseq"] = [[\overset{\text{a.s.}}{=}]],
  ["aeeq"] = [[\overset{\text{a.e.}}{=}]],
  ["asto"] = [[\overset{\text{a.s.}}{\to}]],
  ["amin"] = [[\wedge]],
  ["amax"] = [[\vee]],
  ["pmod"] = [[\pmod{<>}]],
  ["flor"] = [[\floor{<>}]],
  ["ceil"] = [[\ceil{<>}]],
  ["sqrt"] = [[\sqrt{<>}]],
  ["iiit"] = [[\iiint]],
  ["bscp"] = [[\bigsqcup]],
  ["bodt"] = [[\bigodot]],
  ["band"] = [[\bigwedge]],
  ["bcap"] = [[\bigcap]],
  ["bcup"] = [[\bigcup]],
  ["bopl"] = [[\bigoplus]],
  ["boti"] = [[\bigotimes]],
  ["iint"] = [[\iint]],
  ["oint"] = [[\oint]],
  ["prod"] = [[\prod]],
  ["card"] = [[\card]],
  ["asin"] = [[\arcsin]],
  ["acos"] = [[\arccos]],
  ["asec"] = [[\arcsec]],
  ["atan"] = [[\arctan]],
  ["acot"] = [[\arccot]],
  ["acsc"] = [[\arccsc]],
  ["span"] = [[\Span]],
  ["nmid"] = [[\nmid]],
  ["ssub"] = [[\sqsubset]],
  ["prec"] = [[\prec]],
  ["perp"] = [[\perp]],
  ["circ"] = [[\circ]],
  ["cong"] = [[\cong]],
  ["oset"] = [[\emptyset]],
}
local cmd4charwithcom = {
  ["(%a)sta"] = [[%1^{*}]],
  ["(%a)fun"] = [[\fun{%1}{<>}]],
  ["(%a)res"] = [[\res{%1}{<>}]],
  ["cal(%a)"] = function(char)
    return [[\mathcal{]] .. string.upper(char) .. "}"
  end,
  ["scr(%a)"] = function(char)
    return [[\mathscr{]] .. string.upper(char) .. "}"
  end,
  ["frk(%a)"] = [[\mathfrak{%1}]],
  ["(%a)bar"] = [[\overline{%1}]],
  ["(%a)hat"] = [[\hat{%1}]],
  ["(%a)tdl"] = [[\tilde{%1}]],
  ["(%a)vec"] = [[\vec{%1}]],
  ["(%a)dot"] = [[\dot{%1}]],
  ["(%a)cob"] = [[\binom{%1}{<>}]],
}
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
      print("there is conflict in snip " .. cmd .. "=" .. M.cmd4char[cmd] .. " and " .. string.gsub(cmd, k, v))
    end
    M.cmd4char[cmd] = string.gsub(cmd, k, v)
  end
  for i = string.byte("A"), string.byte("Z") do
    local c = string.char(i)
    local cmd = string.format(k1, c)
    if M.cmd4char[cmd] then
      print("there is conflict in snip " .. cmd .. "=" .. M.cmd4char[cmd] .. " and " .. string.gsub(cmd, k, v))
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
