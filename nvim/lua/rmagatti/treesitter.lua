require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["as"] = "@statement.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        -- [""] = "@call.inner",
        -- [""] = "@call.outer",
        ["icl"] = "@class.inner",
        ["acl"] = "@class.outer",
        ["acm"] = "@comment.outer",
        ["icd"] = "@conditional.inner",
        ["acd"] = "@conditional.outer",
        -- [""] = "@frame.inner",
        -- [""] = "@frame.outer",
        ["ir"] = "@parameter.inner",
        ["ar"] = "@parameter.outer",
        -- [""] = "@scopename.inner",
        -- [""] = "@statement.outer",
      },
    },
  },
  autopairs = {
    { enable = true }
  }
}

-- Custom parser
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.terraform = {
  install_info = {
    url = "~/Projects/tree-sitter-terraform", -- local path or git repo
    files = {"src/parser.c"},
  },
  filetype = "terraform", -- if filetype does not agrees with parser name
  used_by = {"hcl2", "tf"} -- additional filetypes that use this parser
}

require "nvim-treesitter.configs".setup {
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
  terraform = {
    enable = true,
    highlight = true
  }
}
