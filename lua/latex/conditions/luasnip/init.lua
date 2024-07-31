local util = require("latex.conditions.util")
local M = {}
function M.in_text()
	local node = util.get_node_at_cursor()
	while node do
		if node:type() == "text_mode" then
			-- For \text{}
			local parent = node:parent()
			if parent and util.MATH_NODES[parent:type()] then
				return false
			end
			return true
		elseif util.MATH_NODES[node:type()] then
			return false
		end
		node = node:parent()
	end
	return true
end

function M.in_comment()
	local node = util.get_node_at_cursor()
	while node do
		if node:type() == "comment" then
			return true
		end
		node = node:parent()
	end
	return false
end
function M.in_math()
	local node = util.get_node_at_cursor()
	while node do
		if util.TEXT_NODES[node:type()] then
			return false
		elseif util.MATH_NODES[node:type()] then
			return true
		end
		node = node:parent()
	end
	return false
end
---judge if the cursor is in some certain environment.
---when check_ancestor is false, will only check the nearest env_nodes.
---when check_ancestor is true, will check all ancestors.
---when in given env, well return a table contains fields env_name:string,args:string[],optional_arg:string
---@return table|false
---@param env_name string|string[]|table<string,boolean>
---@param check_ancestor boolean
function M.in_env(env_name, check_ancestor)
	if type(env_name) == "string" then
		env_name = { env_name }
	end
	for _, v in ipairs(env_name) do
		env_name[v] = true
	end
	local node = util.get_node_at_cursor()
	local buf = vim.api.nvim_get_current_buf()
	local name = ""
	local name_node
	while node do
		if util.ENV_NODES[node:type()] then
			name_node = node:field("begin")[1]:field("name")[1]
			name = vim.treesitter.get_node_text(name_node, buf):match("[A-Za-z]+")
			if env_name[name] then
				local result = { env_name = name, args = {} }
				local begin_node = node:field("begin")[1]
				local optional_arg_node = begin_node:field("options")[1]
				result.optional_arg = optional_arg_node
						and vim.treesitter.get_node_text(optional_arg_node, buf):sub(2, -2)
					or ""
				local arg_node = begin_node:next_sibling()
				while arg_node and string.match(arg_node:type(), "^curly_group") do
					result.args[#result.args + 1] = vim.treesitter.get_node_text(arg_node, buf):sub(2, -2)
					arg_node = arg_node:next_sibling()
				end
				return result
			elseif not check_ancestor then
				return false
			end
		end
		node = node:parent()
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
function M.in_cmd_arg(cmd_name, n, check_ancestor)
	if type(cmd_name) == "string" then
		cmd_name = { cmd_name }
	end
	for _, v in ipairs(cmd_name) do
		cmd_name[v] = true
	end
	local name = ""
	local node = util.get_node_at_cursor()
	if not node then
		return false
	end
	local cmd_node = node:parent()
	local command_name_node
	if cmd_node:type() == "text" then
		node = cmd_node
		cmd_node = node:parent()
	end
	local buf = vim.api.nvim_get_current_buf()
	while cmd_node do
		if not util.CMD_NODES[cmd_node:type()] then
			node = cmd_node
			cmd_node = node:parent()
			goto continue
		end
		command_name_node = cmd_node:field("command")[1]
		name = vim.treesitter.get_node_text(command_name_node, buf):match("[a-zA-Z]+")
		if not cmd_name[name] then
			if not check_ancestor then
				return false
			else
				node = cmd_node
				cmd_node = node:parent()
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
	command_name_node = cmd_node:field("command")[1]
	if not command_name_node then
		return false
	end
	name = vim.treesitter.get_node_text(command_name_node, buf):match("[a-zA-Z]+")
	if not cmd_name[name] then
		return false
	end
	if not n or n == 0 then
		local arg_nodes = cmd_node:field("arg")
		for k, v in ipairs(arg_nodes) do
			if node:equal(v) then
				return k
			end
		end
		return false
	end
	local arg_nodes = cmd_node:field("arg")
	if node:equal(arg_nodes[n]) then
		return n
	end
	return false
end
function M.in_fig()
	return M.in_env("figure", false)
end
function M.in_preamble()
	return not M.in_env("document", true)
end
function M.in_item()
	return M.in_env({ "itemize", "enumerate" }, false)
end
return M
