local L = {}

L.imaps = require("latex.module.imaps")
L.conceal = require("latex.conceal")
L.surrounds = require("latex.module.surrounds")

L.__index = L

L._defaults = {
	conceal = {
		enabled = {
			mathfont = true,
			symbol = true,
			script = true,
			relationship = true,
			operator = true,
			hugeoperator = true,
			others = true,
		},
		disabled = {
			greek = true,
			mathbb = true,
			mathcal = true,
			mathscr = true,
			mathfrak = true,
			mathsf = true,
			mathbbm = true,
			subscript = true,
			superscript = true,
			special = true,
			othersymbol = true,
		},
		conceal_tbl = {
			mathfont = { ["\\mathbb{A}"] = false },
			test = { ["\\test"] = "T" },
			conditiontest = { { condition = require("latex.conditions.query").in_item }, ["\\item"] = "I" },
		},
	},
	imaps = {
		enabled = false,
		add = {},
		default_leader = "`",
	},
	surrounds = {
		enabled = false,
		command = "c",
		environment = "e",
	},
}

function L.setup(args)
	args = vim.tbl_deep_extend("force", L._defaults, args == nil and {} or args)
	L.conceal.init(args.conceal)
	-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	-- 	pattern = { "*.tex" },
	-- 	callback = function()
	-- 		L.conceal.init(args.conceal)
	-- 		L.imaps.init(args.imaps, "tex")
	-- 		L.surrounds.init(args.surrounds)
	-- 	end,
	-- })
	-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	-- 	pattern = { "*.md" },
	-- 	callback = function()
	-- 		L.conceal.init(args.conceal)
	-- 		L.imaps.init(args.imaps, "markdown")
	-- 		L.surrounds.init(args.surrounds)
	-- 	end,
	-- })
	-- vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
	-- 	pattern = { "*.tex", "*.md" },
	-- 	callback = L._deinit,
	-- })
end

function L._deinit() end

return L
