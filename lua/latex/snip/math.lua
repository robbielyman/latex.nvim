local M = {}
M.relation_tbl = {
	["\\bot"] = "⊥", --re
	["\\cong"] = "≅", --re
	["\\doteq"] = "≐", --re
	["\\downarrow"] = "↓", --re
	["\\equiv"] = "≡", --re
	["\\ge"] = "≥", --re
	["\\geq"] = "≥", --re
	["\\gets"] = "←", --re
	["\\iff"] = "⇔", --re
	["\\in"] = "∈", --re
	["\\le"] = "≤", --re
	["\\leftarrow"] = "←", --re
	["\\Leftarrow"] = "⇐", --re
	["\\leftharpoondown"] = "↽", --re
	["\\leftharpoonup"] = "↼", --re
	["\\leftrightarrow"] = "↔", --re
	["\\Leftrightarrow"] = "⇔", --re
	["\\leq"] = "≤", --re
	["\\ll"] = "≪", --re
	["\\mid"] = "∣", --re
	["\\ne"] = "≠", --re
	["\\neq"] = "≠", --re
	["\\ni"] = "∋", --re
	["\\notin"] = "∉", --re
	["\\owns"] = "∋", --re
	["\\parallel"] = "║", --re
	["\\perp"] = "⊥", --re
	["\\prec"] = "≺", --re
	["\\preceq"] = "⪯", --re
	["\\propto"] = "∝", --re
	["\\rightarrow"] = "→", --re
	["\\Rightarrow"] = "⇒", --re
	["\\sim"] = "∼", --re
	["\\simeq"] = "⋍", --re
	["\\sqsubset"] = "⊏", --re
	["\\sqsubseteq"] = "⊑", --re
	["\\sqsupset"] = "⊐", --re
	["\\sqsupseteq"] = "⊒", --re
	["\\subset"] = "⊂", --re
	["\\subseteq"] = "⊆", --re
	["\\succ"] = "≻", --re
	["\\succeq"] = "⪰", --re
	["\\supset"] = "⊃", --re
	["\\supseteq"] = "⊇", --re
	["\\to"] = "→", --re
	["\\uparrow"] = "↑", --re
	["\\vdash"] = "⊢", --re
}
M.greek_tbl = {
	Chi = { expand = "\\Chi", desc = "Χ" },
	Del = { expand = "\\Delta", desc = "Δ" },
	Gam = { expand = "\\Gamma", desc = "Γ" },
	Lam = { expand = "\\Lambda", desc = "Λ" },
	Ome = { expand = "\\Omega", desc = "Ω" },
	Phi = { expand = "\\Phi", desc = "Φ" },
	Pi = { expand = "\\Pi", desc = "Π" },
	Psi = { expand = "\\Psi", desc = "Ψ" },
	Sig = { expand = "\\Sigma", desc = "Σ" },
	The = { expand = "\\Theta", desc = "Θ" },
	Ups = { expand = "\\Upsilon", desc = "Υ" },
	Xi = { expand = "\\Xi", desc = "Ξ" },
	alp = { expand = "\\alpha", desc = "α" },
	bet = { expand = "\\beta", desc = "β" },
	chi = { expand = "\\chi", desc = "χ" },
	del = { expand = "\\delta", desc = "δ" },
	eps = { expand = "\\epsilon", desc = "ϵ" },
	eta = { expand = "\\eta", desc = "η" },
	gam = { expand = "\\gamma", desc = "γ" },
	iot = { expand = "\\iota", desc = "ι" },
	kap = { expand = "\\kappa", desc = "κ" },
	lam = { expand = "\\lambda", desc = "λ" },
	mu = { expand = "\\mu", desc = "μ" },
	nu = { expand = "\\nu", desc = "ν" },
	ome = { expand = "\\omega", desc = "ω" },
	phi = { expand = "\\phi", desc = "ϕ" },
	pi = { expand = "\\pi", desc = "π" },
	psi = { expand = "\\psi", desc = "ψ" },
	rho = { expand = "\\rho", desc = "ρ" },
	sig = { expand = "\\sigma", desc = "σ" },
	tau = { expand = "\\tau", desc = "τ" },
	the = { expand = "\\theta", desc = "θ" },
	ups = { expand = "\\upsilon", desc = "υ" },
	vep = { expand = "\\varepsilon", desc = "ε" },
	vhi = { expand = "\\varphi", desc = "φ" },
	vpi = { expand = "\\varpi", desc = "ϖ" },
	vro = { expand = "\\varrho", desc = "ϱ" },
	vsi = { expand = "\\varsigma", desc = "ς" },
	vth = { expand = "\\vartheta", desc = "ϑ" },
	xi = { expand = "\\xi", desc = "ξ" },
	omi = { expand = "\\omicrom", desc = "o" },
	zet = { expand = "\\zeta", desc = "ζ" },
}
M.arrow_tbl = {
	{ expand = "\\Downarrow", desc = "⇓" },
	{ expand = "\\hookleftarrow", desc = "↩" },
	{ expand = "\\hookrightarrow", desc = "↪" },
	{ expand = "\\nearrow", desc = "↗" },
	{ expand = "\\nwarrow", desc = "↖" },
	{ expand = "\\rightleftharpoons", desc = "⇌" },
	{ expand = "\\searrow", desc = "↘" },
	{ expand = "\\swarrow", desc = "↙" },
	{ expand = "\\Uparrow", desc = "⇑" },
	{ expand = "\\updownarrow", desc = "↕" },
	{ expand = "\\Updownarrow", desc = "⇕" },
	{ expand = "\\downarrow", desc = "↓" },
	{ expand = "\\gets", desc = "←" },
	{ expand = "\\iff", desc = "⇔" },
	{ expand = "\\leftarrow", desc = "←" },
	{ expand = "\\Leftarrow", desc = "⇐" },
	{ expand = "\\leftharpoondown", desc = "↽" },
	{ expand = "\\leftharpoonup", desc = "↼" },
	{ expand = "\\leftrightarrow", desc = "↔" },
	{ expand = "\\Leftrightarrow", desc = "⇔" },
	{ expand = "\\rightarrow", desc = "→" },
	{ expand = "\\Rightarrow", desc = "⇒" },
	{ expand = "\\uparrow", desc = "↑" },
	{ expand = "\\to", desc = "→" },
	{ expand = "\\mapsto", desc = "↦" },
}
M.tbl = {
	["ad"] = [[+]],
	["mn"] = [[-]],
	["pm"] = [[\pm]],
	["mp"] = [[\mp]],
	["in"] = [[\in]],
	["xx"] = [[\times]],
	["or"] = [[\OR]],
	["aa"] = [[\forall]],
	["ee"] = [[\exists]],
	["dd"] = [[\d]],
	["ln"] = [[\ln]],
	["prf"] = [[\vdash]],
	["ind"] = [[\ind]],
	["pto"] = [[\overset{\mathbb{P}}{\to}]],
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
	["ale"] = [[\aleph]],
	["and"] = [[\AND]],
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
