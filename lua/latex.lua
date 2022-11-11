local L = {}

L.__index = L

L._imaps = {
  ["a"] = "\\alpha",
  ["b"] = "\\beta",
  ["c"] = "\\chi",
  ["d"] = "\\delta",
  ["e"] = "\\epsilon",
  ["f"] = "\\phi",
  ["vf"] = "\\varphi",
  ["g"] = "\\gamma",
  ["h"] = "\\eta",
  ["i"] = "\\iota",
  ["k"] = "\\kappa",
  ["l"] = "\\lambda",
  ["m"] = "\\mu",
  ["n"] = "\\nu",
  ["p"] = "\\pi",
  ["q"] = "\\theta",
  ["r"] = "\\rho",
  ["s"] = "\\sigma",
  ["t"] = "\\tau",
  ["u"] = "\\upsilon",
  ["w"] = "\\omega",
  ["x"] = "\\xi",
  ["y"] = "\\psi",
  ["z"] = "\\zeta",
  ["D"] = "\\Delta",
  ["F"] = "\\Phi",
  ["G"] = "\\Gamma",
  ["L"] = "\\Lambda",
  ["P"] = "\\Pi",
  ["Q"] = "\\Theta",
  ["S"] = "\\Sigma",
  ["U"] = "\\Upsilon",
  ["W"] = "\\Omega",
  ["X"] = "\\Xi",
  ["Y"] = "\\Psi",
  ["0"] = "\\varnothing",
  ["6"] = "\\partial",
  ["8"] = "\\infty",
  ["<"] = "\\langle",
  [">"] = "\\rangle",
  ["."] = "\\cdot"
}

function L.setup(args)
  args = args == nil and {} or args
  args.conceals = args.conceals == nil and {} or args.conceals
  args.conceals.enabled = args.conceals.enabled == nil and true or args.conceals.enabled
  args.conceals.add = args.conceals.add and args.conceals.add or {}
  if args.conceals.enabled == true then
    args.conceals.add = vim.tbl_deep_extend("keep", args.conceals.add, L._conceals)
  end
  args.imaps = args.imaps == nil and {} or args.imaps
  args.imaps.enabled = args.imaps.enabled == nil and true or args.imaps.enabled
  args.imaps.add = args.imaps.add and args.imaps.add or {}
  args.imaps.default_leader = args.imaps.default_leader and args.imaps.default_leader or "`"
  if args.imaps.enabled == true then
    args.imaps.add = vim.tbl_deep_extend("keep", args.imaps.add, L._imaps)
  end
  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.tex"},
    callback = function()
      L._init(args, "tex")
    end
  })
  vim.api.nvim_create_autocmd({"BufLeave", "BufWinLeave"}, {
    pattern = {"*.tex"},
    callback = L._deinit
  })
end

function L._deinit()
  print("Left TeX file")
end

function L._init(args, type)
  if type == "tex" then
    print("Entered TeX file")
  elseif type == "markdown" then
    print("Entered markdown file")
  end
end

return L
