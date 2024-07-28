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
local CMD_NODES = {
  generic_command = true,
}
--- get node under cursor
--- @return TSNode|nil
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
--- judge if the cursor is in n-th arg of cmd.
--- cmd_name is the name of cmd without backslash, n is a number. 
--- when n=nil, it will return the number k such that the cursor is in k-th arg if the cursor is in any arg of cmd.
--- --TODO:when n=0, it will return the number k such that the cursor is in k-th arg if the cursor is in optional arg of cmd.
--- check_ancestor means whether to check ancestor. For example, \cmd_name{\othercmd{aa|a}} 
--- will return the number k such that the cursor is in k-th arg if check ancestor is the number k such that the cursor is in k-th arg, but return false when check ancestor is false
--- when cmd_name is a table, will check all cmd_name in the table. return the number k such that the cursor is in k-th arg if at least one of them is found
--- @param cmd_name string|string[]|table<string,boolean>
--- @param n number
--- @param check_ancestor boolean
--- @return boolean|number
function M.in_cmd_arg(cmd_name,n,check_ancestor)
  if type(cmd_name)=="string" then
    cmd_name={cmd_name}
  end
  for _,v in ipairs(cmd_name) do
    cmd_name[v]=true
  end
  local name=""
  local node = get_node_at_cursor()
  if not node then
    return false
  end
  local cmd_node=node:parent()
  local command_name_node
  if cmd_node:type()=="text" then
    node=cmd_node
    cmd_node=node:parent()
  end
  local buf = vim.api.nvim_get_current_buf()
  while cmd_node do
    if not CMD_NODES[cmd_node:type()] then
      node=cmd_node
      cmd_node=node:parent()
      goto continue
    end
    command_name_node=cmd_node:field("command")[1]
    name=vim.treesitter.get_node_text(command_name_node,buf):match("[a-zA-Z]+")
    if not cmd_name[name] then
      if not check_ancestor then 
        return false
      else
        node=cmd_node
        cmd_node=node:parent()
        goto continue
      end
    else
      break
    end
    ::continue::
  end
  if not cmd_node then
    return false
  end
  command_name_node=cmd_node:field("command")[1]
  if not command_name_node then
    return false
  end
  name=vim.treesitter.get_node_text(command_name_node,buf):match("[a-zA-Z]+")
  if not cmd_name[name] then return false end
  if not n or n==0 then
    local arg_nodes=cmd_node:field("arg")
    for k,v in ipairs(arg_nodes) do
      if node:equal(v) then
        return k
      end
    end
    return false
  end
  local arg_nodes=cmd_node:field("arg")
  if node:equal(arg_nodes[n]) then
    return n
  end
  return false
end
function M.in_fig()
  return M.in_env("figure",false)
end
function M.in_preamble()
  return not M.in_env("document",true)
end
return M
