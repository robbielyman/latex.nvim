local M = {}
local conceal_tbls = vim.api.nvim_get_runtime_file("lua/latex/conceal/conceal_tbl/*.lua", true)
M.conditions = require("latex.conditions.query")
M.conceal_tbl = {}
for _, v in ipairs(conceal_tbls) do
	local filename = string.match(v, "/([a-zA-A_]*)%.lua")
	local tbl = dofile(v)
	if not tbl[1] then
		error("Illedgal tbl in " .. v .. ": no [1]")
		goto continue
	end
	if tbl[1].type == "simple" then
		M.conceal_tbl[filename] = tbl
	elseif tbl[1].type == "mutiple" then
		local cache = {}
		for kk, vv in pairs(tbl) do
			if kk ~= 1 then
				M.conceal_tbl[kk] = vv
				cache[#cache + 1] = vv
			end
		end
		M.conceal_tbl[filename] = vim.tbl_extend("force", unpack(cache))
	else
		error("Illedgal tbl in " .. v .. ": [1].type missing")
	end
	::continue::
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
-- local function hasgrandparent(match, _, _, predicate)
-- 	local node = match[predicate[2]]
-- 	for _ = 1, 2 do
-- 		if not node then
-- 			return false
-- 		end
-- 		node = node:parent()
-- 	end
-- 	if not node then
-- 		return false
-- 	end
-- 	local ancestor_types = { unpack(predicate, 3) }
-- 	if vim.tbl_contains(ancestor_types, node:type()) then
-- 		return true
-- 	end
-- 	return false
-- end

local function is_in_conceal_table(match, _, source, predicate)
	local node = match[predicate[2]]
	if not node then
		return false
	end
	local tablename = predicate[3]
	if not M.conceal_tbl[tablename] then
		return false
	end
	local node_text = vim.treesitter.get_node_text(node, source)
	if M.conceal_tbl[tablename][node_text] then
		return true
	else
		return false
	end
end
local function latex_condition(match, _, source, predicate) end
--- (math_environment (label_definition) @label) @equation (#label! @equation @label)
--- add label to equation
-- local function label_equation(match,_,source,predicate)
--   local equation_node = match[predicate[2]]
--   local label_node = match[predicate[3]]
--   if not (equation_node and label_node) then return end
--   local label_text = vim.treesitter.get_node_text(label_node, source)
--   local row,_,_,_=equation_node:range(false)
--   local ns_id=vim.api.nvim_create_namespace("latex")
--   vim.api.nvim_buf_set_extmark(0,ns_id,row,1,{
--     virt_text={{label_text,"@label"}},
--     virt_text_pos="right_align",
--   })
-- end

local function latexconceal(match, _, source, predicate, metadata)
	local capture_id = predicate[2]
	local node = match[capture_id]
	local concealtype = predicate[3]
	if not node then
		return
	end
	local node_text = vim.treesitter.get_node_text(node, source)
	-- if metadata[capture_id] and metadata[capture_id].range then
	--   local sr, sc, er, ec = unpack(metadata[capture_id].range)
	--   node_text = vim.api.nvim_buf_get_text(source, sr, sc, er, ec, {})[1]
	-- end
	metadata.conceal = M.conceal_tbl[concealtype][node_text]
end
-- local function setpairs(match, _, source, predicate, metadata)
-- 	-- (#set-pairs! @aa key list)
-- 	local capture_id = predicate[2]
-- 	local node = match[capture_id]
-- 	local key = predicate[3]
-- 	if not node then
-- 		return
-- 	end
-- 	local node_text = vim.treesitter.get_node_text(node, source)
-- 	-- if metadata[capture_id] and metadata[capture_id].range then
-- 	--   local sr, sc, er, ec = unpack(metadata[capture_id].range)
-- 	--   node_text = vim.api.nvim_buf_get_text(source, sr, sc, er, ec, {})[1]
-- 	-- end
-- 	for i = 4, #predicate, 2 do
-- 		if node_text == predicate[i] then
-- 			metadata[key] = predicate[i + 1]
-- 			break
-- 		end
-- 	end
-- end

local function load_queries(args)
	local filenames = vim.treesitter.query.get_files("latex", "highlights")
	-- vim.treesitter.query.add_predicate("has-grandparent?", hasgrandparent, true)
	vim.treesitter.query.add_predicate("conceal-table?", is_in_conceal_table, true)
	-- vim.treesitter.query.add_directive("set-pairs!", setpairs, true)
	vim.treesitter.query.add_directive("latexconceal!", latexconceal, true)
	-- vim.treesitter.query.add_directive('label_equation!', label_equation, true)
	for _, name in ipairs(args.enabled) do
		local files = vim.api.nvim_get_runtime_file("queries/latex/conceal_" .. name .. ".scm", true)
		for _, file in ipairs(files) do
			table.insert(filenames, file)
		end
	end
	local strings = read_query_files(filenames) or ""
	local added_query_start = [[(generic_command
    command: ((command_name) @text.math
    (#any-of? @text.math
  ]]
	local added_query_middle = [[
  ))
  (#set-pairs! @text.math conceal
  ]]
	local added_query_end = "))"
	for command, conceal in pairs(args.add) do
		added_query_start = added_query_start .. '"\\\\' .. command .. '" '
		added_query_middle = added_query_middle .. '"\\\\' .. command .. '" "' .. conceal .. '" '
	end
	if next(args.add) then
		strings = strings .. added_query_start .. added_query_middle .. added_query_end
	end
	vim.treesitter.query.set("latex", "highlights", strings)
end

function M.init(args)
	if args.enabled == false then
		return
	end
	load_queries(args)
end

return M
