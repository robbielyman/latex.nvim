local ts_utils = require 'nvim-treesitter.ts_utils'

local M = {}

M._defaults = {
  ["\\alpha"] = "a",
  ["\\beta"] = "b",
  ["\\chi"] = "c",
  ["\\delta"] = "d",
  ["\\epsilon"] = "e",
  ["\\phi"] = "f",
  ["\\varphi"] = "vf",
  ["\\gamma"] = "g",
  ["\\eta"] = "h",
  ["\\iota"] = "i",
  ["\\kappa"] = "k",
  ["\\lambda"] = "l",
  ["\\mu"] = "m",
  ["\\nu"] = "n",
  ["\\pi"] = "p",
  ["\\theta"] = "q",
  ["\\rho"] = "r",
  ["\\sigma"] = "s",
  ["\\tau"] = "t",
  ["\\upsilon"] = "u",
  ["\\omega"] = "w",
  ["\\xi"] = "x",
  ["\\psi"] = "y",
  ["\\zeta"] = "z",
  ["\\Delta"] = "D",
  ["\\Phi"] = "F",
  ["\\Gamma"] = "G",
  ["\\Lambda"] = "L",
  ["\\Pi"] = "P",
  ["\\Theta"] = "Q",
  ["\\Sigma"] = "S",
  ["\\Upsilon"] = "U",
  ["\\Omega"] = "W",
  ["\\Xi"] = "X",
  ["\\Psi"] = "Y",
  ["\\varnothing"] = "0",
  ["\\partial"] = "6",
  ["\\infty"] = "8",
  ["\\langle"] = "<",
  ["\\rangle"] = ">",
  ["\\cdot"] = ".",
  ["\\mathbb"] = {
    lhs = "B",
    leader = "#",
    wrap_char = true
  },
  ["\\mathbf"] = {
    lhs = "b",
    leader = "#",
    wrap_char = true
  },
  ["\\mathcal"] = {
    lhs = "c",
    leader = "#",
    wrap_char = true
  },
  ["\\mathscr"] = {
    lhs = "s",
    leader = "#",
    wrap_char = true
  },
  ["\\mathsf"] = {
    lhs = "S",
    leader = "#",
    wrap_char = true
  },
  ["\\mathfrak"] = {
    lhs = "f",
    leader = "#",
    wrap_char = true
  }
}

function M.init(args, filetype)
  if args.enabled then
    args.add = vim.tbl_deep_extend("force", M._defaults, args.add)
    if filetype == "tex" then
      M._init_tex(args)
    elseif filetype == "markdown" then
      M._init_markdown(args)
    end
  end
end

function M._init_tex(args)
  for rhs, map in pairs(args.add) do
    if type(map) == "string" then
      map = {
        lhs = map,
        leader = args.default_leader,
        wrap_char = false,
        context = M.tex_math_mode,
      }
      vim.keymap.set("i", map.leader .. map.lhs, function()
        if map.context == nil then
          map.context = M.tex_math_mode
        end
        if map.context() then
          if not map.wrap_char then
            return rhs
          else
            local char = vim.api.nvim_eval('nr2char(getchar())')
            return rhs .. "{" .. char .. "}"
          end
        else
          return map.leader .. map.lhs
        end
      end, {buffer = true, expr = true})
    end
  end
end

function M._init_markdown(args)
  for rhs, map in pairs(args.add) do
    if type(map) == "string" then
      map = {
        lhs = map,
        leader = args.default_leader,
        wrap_char = false,
        context = M.markdown_math_mode,
      }
      vim.keymap.set("i", map.leader .. map.lhs, function()
        if map.context == nil then
          map.context = M.markdown_math_mode
        end
        if map.context() then
          if not map.wrap_char then
            return rhs
          else
            local char = vim.api.nvim_eval('nr2char(getchar())')
            return rhs .. "{" .. char .. "}"
          end
        else
          return map.leader .. map.lhs
        end
      end, {buffer = true, expr = true})
    end
  end
end

function M.any_mode()
  return true
end

function M.tex_math_mode()
  local node = ts_utils.get_node_at_cursor()
  local root
  if node then
    root = ts_utils.get_root_for_node(node)
  end
  if not root then
    return false
  end
  local parent
  if node then
    parent = node:parent()
  end
  while node ~= nil and node ~= root do
    local t = node:type()
    if t == "label_definition" or t == "text_mode" then
      return false
    elseif t == "inline_formula" or t == "displayed_equation" then
      return true
    elseif t == "ERROR" then
      local start_row, start_col, end_row, end_col = ts_utils.get_node_range(node)
      local tab = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
      for _, text in ipairs(tab) do
        if string.find(text, "%$") or string.find(text, "\\%[") then
          return true
        end
      end
    end
    node = parent
    if node then
      parent = node:parent()
    end
  end
  return false
end

function M.markdown_math_mode()
  local node = ts_utils.get_node_at_cursor()
  local root
  if node then
    root = ts_utils.get_root_for_node(node)
  end
  if not root then
    return false
  end
  local parent
  if node then
    parent = node:parent()
  end
  while node ~= nil and node ~= root do
    local t = node:type()
    if t == "inline" then
      local start_row, _, end_row, _ = ts_utils.get_node_range(node)
      local tab = vim.api.nvim_buf_get_lines(0, start_row, end_row, false)
      local row, col = vim.api.nvim_win_get_cursor()
      local inside = false
      for i, text in ipairs(tab) do
        if i > row - start_row + 1 then break end
        local index = 0
        while true do
          _, index = string.find(text, "%$%$", index + 1)
          if not index then break end
          if i == row - start_row + 1 then
            if index > col + 1 then break end
          end
          inside = not inside
        end
      end
      return inside
    end
    node = parent
    if node then
      parent = node:parent()
    end
  end
  return false
end

return M
