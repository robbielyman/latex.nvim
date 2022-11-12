local L = {}

L.imaps = require('module.imaps')

L.__index = L

L._conceals = {}

function L.setup(args)
  if args == nil or args == {} then
    args = {
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
  else
    if args.conceals == nil then
      args.conceals = {
        enabled = true,
        add = {}
      }
    end
    if args.imaps == nil then
      args.imaps = {
        enabled = true,
        add = {},
        default_leader = "`"
      }
    elseif args.imaps.default_leader == nil then
      args.imaps.default_leader = "`"
    end
  end
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
