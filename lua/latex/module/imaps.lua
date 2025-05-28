local ts_utils = require("nvim-treesitter.ts_utils")

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
    wrap_char = true,
  },
  ["\\mathbf"] = {
    lhs = "b",
    leader = "#",
    wrap_char = true,
  },
  ["\\mathcal"] = {
    lhs = "c",
    leader = "#",
    wrap_char = true,
  },
  ["\\mathscr"] = {
    lhs = "s",
    leader = "#",
    wrap_char = true,
  },
  ["\\mathsf"] = {
    lhs = "S",
    leader = "#",
    wrap_char = true,
  },
  ["\\mathfrak"] = {
    lhs = "f",
    leader = "#",
    wrap_char = true,
  },
}

function M.tex_math_mode()
  local node = ts_utils.get_node_at_cursor(0)
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
    elseif t == "inline_formula" or t == "displayed_equation" or t == "math_environment" then
      return true
    elseif t == "ERROR" then
      local tab = vim.treesitter.get_node_text(node, 0)
      if type(tab) == "string" then
        tab = { tab }
      end
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
  if M.tex_math_mode() then
    return true
  end
  local node = ts_utils.get_node_at_cursor(0)
  local parent
  if node then
    parent = node:parent()
  end
  while node ~= nil do
    local t = node:type()
    if t == "inline" then
      local start_row, _, end_row, _ = vim.treesitter.query.get_node_range(node)
      local tab = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local inside = false
      for i, text in ipairs(tab) do
        if i > row - start_row then
          break
        end
        local index = 0
        local flag = false
        repeat
          _, index = string.find(text, "%$%$", index)
          if index then
            if i == row - start_row then
              if index > col + 1 then
                flag = true
              else
                inside = not inside
              end
            else
              inside = not inside
            end
          else
            flag = true
          end
        until flag == true
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

local tex_default_map = {
  wrap_char = false,
  context = M.tex_math_mode,
}

local markdown_default_map = {
  wrap_char = false,
  context = M.markdown_math_mode,
}

function M.init(args, filetype)
  if args.enabled then
    args.add = vim.tbl_deep_extend("force", M._defaults, args.add)
    tex_default_map.leader = args.default_leader
    markdown_default_map.leader = args.default_leader
    if filetype == "tex" then
      M._init_tex(args)
    elseif filetype == "markdown" then
      M._init_markdown(args)
    end
  end
end

function M._init_tex(args)
  vim.treesitter.language.register("latex", "tex")
  vim.treesitter.language.register("latex", "plaintex")
  for rhs, map in pairs(args.add) do
    if type(map) == "string" then
      map = {
        lhs = map,
      }
    end
    map = vim.tbl_deep_extend("force", tex_default_map, map)
    vim.keymap.set("i", map.leader .. map.lhs, function()
      if map.context() then
        if not map.wrap_char then
          return rhs
        else
          local char = vim.api.nvim_eval("nr2char(getchar())")
          return rhs .. "{" .. char .. "}"
        end
      else
        return map.leader .. map.lhs
      end
    end, { buffer = true, expr = true, desc = rhs .. (map.wrap_char and "{}" or "") })
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
    end
    map = vim.tbl_deep_extend("force", markdown_default_map, map)
    vim.keymap.set("i", map.leader .. map.lhs, function()
      if map.context() then
        if not map.wrap_char then
          return rhs
        else
          local char = vim.api.nvim_eval("nr2char(getchar())")
          return rhs .. "{" .. char .. "}"
        end
      else
        return map.leader .. map.lhs
      end
    end, { buffer = true, expr = true, desc = rhs .. (map.wrap_char and "{}" or "") })
  end
end

function M.any_mode()
  return true
end

return M
