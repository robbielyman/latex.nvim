local L = {}

L.imaps = require('latex.module.imaps')

L.__index = L

L._conceals = {}

L._defaults = {
  conceals = {
    enabled = true,
    add = {}
  },
  imaps = {
    enabled = true,
    add = {},
    default_leader = "`"
  }
}

function L.setup(args)
  args = vim.tbl_deep_extend("force", L._defaults, args)
  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.tex"},
    callback = function()
      L.imaps.init(args.imaps, "tex")
    end
  })
  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.md"},
    callback = function()
      L.imaps.init(args.imaps, "markdown")
    end
  })
  vim.api.nvim_create_autocmd({"BufLeave", "BufWinLeave"}, {
    pattern = {"*.tex", "*.md"},
    callback = L._deinit
  })
end

function L._deinit()
end

return L
