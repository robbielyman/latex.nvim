local M={}
local MATH_NODES = {
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
}

local TEXT_NODES = {
  text_mode = true,
  label_definition = true,
  label_reference = true,
}
local ENV_NODES = {
  generic_environment=true,
  math_environment=true,
  comment_environment=true,
  verbatim_environment=true,
  listing_environment=true,
  minted_environment=true,
  pycode_environment=true,
  sagesilent_environment=true,
  sageblock_environment=true,
}

local function get_node_at_cursor()
  local pos = vim.api.nvim_win_get_cursor(0)
  -- Subtract one to account for 1-based row indexing in nvim_win_get_cursor
  local row, col = pos[1] - 1, pos[2]

  local parser = vim.treesitter.get_parser(0, "latex")
  if not parser then
    return
  end

  local root_tree = parser:parse({ row, col, row, col })[1]
  local root = root_tree and root_tree:root()
  if not root then
    return
  end

  return root:named_descendant_for_range(row, col, row, col)
end

function M.in_text(check_parent)
  local node = get_node_at_cursor()
  while node do
    if node:type() == "text_mode" then
      if check_parent then
        -- For \text{}
        local parent = node:parent()
        if parent and MATH_NODES[parent:type()] then
          return false
        end
      end

      return true
    elseif MATH_NODES[node:type()] then
      return false
    end
    node = node:parent()
  end
  return true
end

function M.in_comment()
    local node = get_node_at_cursor()
    while node do
      if node:type() == "comment" then
        return true
      end
      node = node:parent()
    end
    return false
end

function M.in_math()
  local node = get_node_at_cursor()
  while node do
    if TEXT_NODES[node:type()] then
      return false
    elseif MATH_NODES[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

function M.in_env(env_name,check_parent)
  local node = get_node_at_cursor()
  local buf = vim.api.nvim_get_current_buf()
  local name=""
  local name_node
  while node do
    if ENV_NODES[node:type()] then
      name_node=node:field("begin")[1]:field("name")[1]
      name=vim.treesitter.get_node_text(name_node,buf):match("[A-Za-z]+")
      if name == env_name then
        return true
      elseif not check_parent then
        return false
      end
    end
    node=node:parent()
  end
end
function M.in_fig()
  return M.in_env("figure",false)
end
function M.in_preamble()
  return not M.in_env("document",true)
end
return M
