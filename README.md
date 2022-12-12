# latex.nvim

(very) minimal, opinionated neovim filetype plugin for (La)TeX and Markdown, written in Lua.
There is no reason to prefer this plugin to [VimTeX](https://github.com/lervag/vimtex).

## Installation

```lua
-- packer.nvim
use 'ryleelyman/latex.nvim'
```

## Requirements

To use `imaps`, which are based on [treesitter](https://github.com/nvim-treesitter/nvim-treesitter),
you must have treesitter parsers for the relevant filetype installed.
For example, `latex` for `.tex` files
and `markdown` and `markdown_inline` for `.md` files.

## Configuration

To use `latex.nvim` you need to put

```lua
require('latex').setup()
```

somewhere in your config.
This is equivalent to the following default configuration.

```lua
require('latex').setup{
  conceals = {
    enabled = {
      "greek",
      "math",
      "script",
      "delim",
      "font"
    },
    add = {}
  },
  imaps = {
    enabled = true,
    add = {},
    default_leader = "`"
  },
  surrounds = {
    enabled = false,
    command = "c",
    environment = "e",
  },
}
```

See below for more about configuring `imaps`.

## Features

### Imaps

Currently `latex.nvim` provides user-configurable, context-aware insert-mode mappings
in `.tex` and `.md` files.
The mappings are directly inspired by [VimTeX](https://github.com/lervag/vimtex).

The `imaps.add` table in `setup()` expects one of the following formats

```lua
{
  ["rhs"] = "lhs",
  -- the above is equivalent to
  ["rhs"] = {
    lhs = "lhs",
    leader = nil, -- will be replaced by default_leader
    wrap_char = false,
    context = nil -- will be replaced by one of require('latex').imaps.tex_math_mode or require('latex').imaps.markdown_math_mode
  }
}
```

Assuming a `default_leader` of "\`", typing "\`lhs" while within math mode
(e.g. between a pair of `$` or a `\[`, `\]` block in a `.tex` file,
or between a pair of `$$` in a `.md` file)
will yield an output of "rhs".

#### `wrap_char`

A mapping with `wrap_char = true`,
for example the default mapping

```lua
{
  ["\\mathbb"] = {
    lhs = "B",
    leader = "#",
    wrap_char = true
  }
 }
 ```
 yields, after inputting "#BZ" in math mode, the output "\mathbb{Z}".
 
 ### Conceals
 
 Almost all of the low-hanging fruit is done as far as concealing;
 hard things like using tree-sitter for `\'e` to `é` are not a priority.
 
 You can disable conceals on a per-file basis by redefining `conceals.enabled` in the `setup` function.
 
 Currently the conceals provided are:
 - Greek: things like `\sigma` to `σ`
 - Math: things like `\amalg` to `⨿`
 - Script: superscripts and subscripts
 - Delim: things like `\left` and many instances of curly braces.
 - Font: things like `\mathbb{Z}` to `ℤ`

You can add your own concealed commands to the `conceals.add` table in the following format

```lua
add = {
  ["colon"] = ":"
}
```

The key should be the command name with the leading backslash stripped,
and the value should be the single-character conceal to replace that command with.
The `add` table is for concealing `generic_command` elements.
Unlike most other conceals, these are *not* sensitive to the presence or absence of math mode.
 
 ### Surrounds

 Requires [nvim-surround](https://github.com/kylechui/nvim-surround).
 Provides `add`, `change` and `delete` for commands and environments.
 With default settings for `nvim-surround`, these are mapped to,
 for example, `csc` for `c`hange `s`urrounding `c`ommand and
 `dse` for `d`elete `s`urrounding `e`nvironment.

 To enable, set `surrounds.enabled` to `true`.

 ## Non-features
 
 - compilation, forward/backward search, completion, linting—use [texlab](https://github.com/latex-lsp/texlab)
 - highlighting—use treesitter
