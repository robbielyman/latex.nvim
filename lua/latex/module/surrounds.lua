local M = {}

function M.init(config)
  if not config.enabled then return end
  require("nvim-surround").buffer_setup {
    surrounds = {
      [config.command] = {
        add = function()
          local cmd = require("nvim-surround.config").get_input "Command: "
          return { { "\\" .. cmd .. "{" }, { "}" } }
        end,
        find = function()
          return require("nvim-surround.config").get_selection{
            node = {"generic_command", "label_definition"}
          }
        end,
        change = {
          target = "^\\([^%{]*)().-()()$",
          replacement = function ()
            local cmd = require("nvim-surround.config").get_input "Command: "
            return { { cmd } , { } }
          end
        },
        delete = function ()
          local sel = require("nvim-surround.config").get_selections{
            char = config.command,
            pattern = "^(\\.-{)().-(})()$"
          }
          if sel then return sel end
          return require("nvim-surround.config").get_selections{
            char = config.command,
            pattern = "^(\\.*)().-()()$"
          }
        end
      },
      [config.environment] = {
        add = function()
          local env = require("nvim-surround.config").get_input "Environment: "
          return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
        end,
        find = function ()
          return require("nvim-surround.config").get_selection{
            node = {"generic_environment", "math_environment"}
          }
        end,
        delete = function()
          local sel = require("nvim-surround.config").get_selections{
            char = config.environment,
            pattern = "^(\\begin%b{}%b[])().-(\\end%b{})()$"
          }
          if sel then return sel end
          return require("nvim-surround.config").get_selections{
            char = config.environment,
            pattern = "^(\\begin%b{})().-(\\end%b{})()$"
          }
        end,
        change = {
          target = "^\\begin{([^%}]*)().-\\end{([^%}]*)()}$",
          replacement = function ()
            local cmd = require("nvim-surround.config").get_input "Environment: "
            return { { cmd }, { cmd } }
          end
        }
      },
    },
  }
end

return M
