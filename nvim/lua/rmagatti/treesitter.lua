require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "lua", "typescript", "terraform" },

  auto_install = true,
  sync_install = false,
  ignore_install = { "haskell" },
  indent = {
    enable = true
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  textsubjects = {
    enable = true,
    prev_selection = ",", -- (Optional) keymap to select the previous selection
    keymaps = {
      ["."] = "textsubjects-smart",
      ["ac"] = "textsubjects-container-outer",
      ["ic"] = "textsubjects-container-inner",
    },
  },

  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
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

  -- terraform = {
  --   enable = true,
  --   highlight = true,
  -- },
  -- typescript = {
  --   enable = true,
  --   highlight = true,
  -- },
  -- lua = {
  --   enable = true,
  --   highlight = true,
  --   additional_vim_regex_highlighting = false,
  -- },
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

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.ejs = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
    files = { "src/parser.c" },
    requires_generate_from_grammar = true,
  },
  filetype = "ejs",
}

-- Reset treesitter
vim.cmd [[
  nnoremap <leader>rt <cmd>w <bar> e <bar> TSBufEnable highlight <bar> set syntax=off<CR>
]]
