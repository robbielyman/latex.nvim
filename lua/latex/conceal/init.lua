local M = {}
M.conditions = require("latex.conditions.query")
M.conceal_tbl = {}

---@return string #the query made by conceal_tbl
---@param conceal_tbl ConcealTable #the conceal_tbl
---This function well make a query to match the context in conceal_tbl
local function make_query(conceal_tbl)
	if conceal_tbl[1].no_query then
		return ""
	end
	local hi_group = conceal_tbl[1].highlight
	local name = conceal_tbl[1].name
	if not conceal_tbl[1].query_file then
		local query = conceal_tbl[1].query
			or (
				[[((generic_command) ]]
				.. hi_group
				.. [[

(#conceal-table? ]]
				.. hi_group
				.. [[ "]]
				.. name
				.. [[")
(#latexconceal! ]]
				.. hi_group
				.. [[ "]]
				.. name
				.. [[")(#set! priority 105))

      ]]
			)
		return query
	else
		local filename = conceal_tbl[1].query_file
		filename = vim.api.nvim_get_runtime_file("queries/latex/conceal_" .. filename .. ".scm", true)[1]
		local file, err = io.open(filename, "r")
		local payload = ""
		if file then
			payload = file:read("*a")
			io.close(file)
		else
			error(err)
		end
		return payload .. "\n"
	end
end

---@return ConcealTable[]
---@param conceal_tbls table<string,ConcealTableSimple>
local function add_conceal_table(conceal_tbls)
	for name, conceal_tbl in pairs(conceal_tbls) do
		if type(name) == "string" then
			conceal_tbl[1] = vim.tbl_extend("force", {
				name = name,
				type = "simple",
				condition = nil,
				highlight = "@" .. name,
				no_query = false,
				query_file = nil,
				query = nil,
			}, conceal_tbl[1] or {})
			if conceal_tbl[1].type == "mutiple" then
				local i = 1
				local cache = {}
				for k, v in pairs(add_conceal_table(conceal_tbl)) do
					if type(k) == "string" then
						cache[i] = v
						i = i + 1
					end
				end
				M.conceal_tbl[name] = vim.tbl_deep_extend("force", M.conceal_tbl[name] or {}, unpack(cache, 1))
				M.conceal_tbl[name][1] = vim.tbl_deep_extend("force", M.conceal_tbl[name][1] or {}, conceal_tbl[1])
			else
				M.conceal_tbl[name] = vim.tbl_deep_extend("force", M.conceal_tbl[name] or {}, conceal_tbl)
			end
		end
	end
	return conceal_tbls
end
local function read_conceal_tbls()
	local conceal_tbls = vim.api.nvim_get_runtime_file("lua/latex/conceal/conceal_tbl/*.lua", true)
	for _, v in ipairs(conceal_tbls) do
		local filename = string.match(v, "/([a-zA-A_]*)%.lua")
		local tbl = dofile(v)
		add_conceal_table({ [filename] = tbl })
	end
end

local function read_query_files(filenames)
	local contents = ""
	for _, filename in ipairs(filenames) do
		local file, err = io.open(filename, "r")
		local payload = ""
		if file then
			payload = file:read("*a")
			io.close(file)
		else
			error(err)
		end
		contents = contents .. "\n" .. payload
	end
	return contents
end

local function is_in_conceal_table(match, _, source, predicate)
	local node = match[predicate[2]]
	if not node then
		return false
	end
	local tablename = predicate[3]
	if not M.conceal_tbl[tablename] then
		return false
	end
	local condition = M.conceal_tbl[tablename] and M.conceal_tbl[tablename][1] and M.conceal_tbl[tablename][1].condition
	if type(condition) == "string" then
		condition = M.conditions[condition] or error("Not valid condition:" .. condition)
	end
	if condition ~= nil then
		if not condition(node, source) then
			return false
		end
	end
	local node_text = vim.treesitter.get_node_text(node, source)
	if M.conceal_tbl[tablename][node_text] then
		return true
	else
		return false
	end
end
local function latex_condition(match, _, source, predicate)
	local node = match[predicate[2]]
	if not node then
		return false
	end
	local condition = predicate[3]
	condition = M.conditions[condition] or error("Not valid condition:" .. condition)
	if condition ~= nil then
		return condition(node, source)
	end
	return true
end

local function latexconceal(match, _, source, predicate, metadata)
	local capture_id = predicate[2]
	local node = match[capture_id]
	local concealtype = predicate[3]
	if not node then
		return
	end
	local node_text = vim.treesitter.get_node_text(node, source)
	metadata.conceal = M.conceal_tbl[concealtype][node_text]
end

local function load_queries(args)
	local filenames = vim.treesitter.query.get_files("latex", "highlights")
	-- vim.treesitter.query.add_predicate("has-grandparent?", hasgrandparent, true)
	vim.treesitter.query.add_predicate("conceal-table?", is_in_conceal_table, true)
	vim.treesitter.query.add_predicate("latex-condition?", latex_condition, true)
	-- vim.treesitter.query.add_directive("set-pairs!", setpairs, true)
	vim.treesitter.query.add_directive("latexconceal!", latexconceal, true)
	-- vim.treesitter.query.add_directive('label_equation!', label_equation, true)
	local strings = read_query_files(filenames) or ""
	add_conceal_table(args.add)
	for k, v in pairs(M.conceal_tbl) do
		if true and not args.disabled[k] then
			strings = make_query(v) .. strings
		end
	end
	vim.treesitter.query.set("latex", "highlights", strings)
end

function M.init(args)
	if args.enabled == false then
		return
	end
	read_conceal_tbls()
	load_queries(args)
end

return M
