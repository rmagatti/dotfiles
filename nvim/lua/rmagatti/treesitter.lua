require("nvim-treesitter.configs").setup {
  enable = true,
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
      },
    },
  },
  autopairs = {
    { enable = true },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      ["'"] = "textsubjects-big",
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    lsp_interop = { -- TODO: Not sure how this works or if it's useful, figure it out or remove
      enable = true,
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
  },
  context_commentstring = {
    enable = true,
  },
}

-- -- Custom parser
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

-- parser_config.hcl = {
--   install_info = {
--     url = "~/Projects/tree-sitter-hcl", -- local path or git repo
--     files = { "src/parser.c", "src/scanner.cc" },
--   },
--   filetype = "tf", -- if filetype does not agrees with parser name
--   used_by = { "hcl", "tf", "terraform" }, -- additional filetypes that use this parser
-- }

-- parser_config.typescript = {
--   install_info = {
--     url = "~/Projects/tree-sitter-typescript/typescript",
--     files = { "src/parser.c", "src/scanner.c" },
--     -- location = "tree-sitter-typescript/typescript",
--     generate_requires_npm = true,
--   },
-- }

require("nvim-treesitter.configs").setup {
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  terraform = {
    enable = true,
    highlight = true,
  },
  typescript = {
    enable = true,
    highlight = true,
  },
  -- tree_docs = {
  --   enable = true,
  --   -- keymap = ,
  --   spec_config = {
  --     jsdoc = {
  --       slots = {
  --         class = {author = true}
  --       }
  --     }
  --   }
  -- }
}

vim.cmd [[
  " Reset treesitter
  nnoremap <leader>rt <cmd>w <bar> e <bar> TSBufEnable highlight <bar> set syntax=off<CR>
]]
