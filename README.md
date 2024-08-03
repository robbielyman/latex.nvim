# latex.nvim

An neovim plugin for LaTeX, written in Lua. 
Although it's simple now, I want to make it as powerful as [VimTeX](https://github.com/lervag/vimtex) one day. 

## Installation

```lua
-- lazy.nvim
{"dirichy/latex.nvim",
    ft="tex",
    config=function()
        require("latex").setup()
    end
}
```

## Requirements

[treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for conceal and snip.
(Not finished)[LuaSnip](https://github.com/L3MON4D3/LuaSnip) for snip.
(Not finished)[nvim-cmp](https://github.com/hrsh7th/nvim-cmp) for display desc of snip.
[plenary.nvim](https://github.com/nvim-lua/plenary.nvim) for compile.
(now only support arara)`arara` or `latexmk` for compile. 

## Configuration

You can config this plugin by
```lua
require("latex").setup(opts)
```
By now, there is only one field `opts.conceal.conceal_tbl` can be set manmully. 
You can set it as 
```lua
opts={
    conceal={
        conceal_tbl={
            --To conceal generic_command in math
            --highlight is the hightgroup, should begin with "@".
            --condition function(Node,source) -> boolean, onlly match afterwards keys when conditon is true. 
            myfirst_conceal_group = {
                {highlight="@mygroup",condition=require("latex.conditions.query").in_math},
                ["\\test"]="T",
                ["\\Alpha"]="A",
                ["\\mathbb{A}"]="A",
            }
            --To conceal other group, you need to provide query by yourself
            --If you don't set highlight, the default highlight is same as group name
            --condition=nil means no condition. 
            --conceal-table and latexconceal are functions defined in latex/conceal/init.lua to do conceal easily. 
            script = {
                {highlight=nil--equal to highlight="@script"
                query='((script) @script (#conceal-table? @script)(#latexconceal! @script "script")',
                condition=nil}
                ["_1"]="₁",
            }
            --There are some condition in require("latex.conditions.query"), and you can set condition mamully. 
            --you can put query in a file, too. 
            delim = {
                {
                    highlight="@conceal",
                    query_file="delete"--will load runtimepath/queries/latex/conceal_delete.scm
                }
            }
        }
    }
}
```
## Features

### Snips

I don't like let my finger leave the main field of keyboard, so I use autosnip construct by pure alphabet. 
For now I didn't add my LuaSnips in this plugin, but I will add them later. 

 ### Conceals
 
 Almost all of the low-hanging fruit is done as far as concealing;
 hard things like using tree-sitter for `\'e` to `é` are not a priority.
 
 Currently the conceals provided are:
 - Greek: things like `\sigma` to `σ`
 - Math: things like `\amalg` to `⨿`
 - Script: superscripts and subscripts
 - Delim: things like `\left` and many instances of curly braces.
 - Font: things like `\mathbb{Z}` to `ℤ`
 
 We can use different colors for different conceal, which make our tex file more readable. 
 You can add your own concealed commands to the `conceal.conceal_tbl` table, see Configuration

<!-- # ### Surrounds
 #
 # Requires [nvim-surround](https://github.com/kylechui/nvim-surround).
 # Provides `add`, `change` and `delete` for commands and environments.
 # With default settings for `nvim-surround`, these are mapped to,
 # for example, `csc` for `c`hange `s`urrounding `c`ommand and
 # `dse` for `d`elete `s`urrounding `e`nvironment.
 #
 # To enable, set `surrounds.enabled` to `true`. -->
