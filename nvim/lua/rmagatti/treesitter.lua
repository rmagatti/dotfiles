---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "typescript", "terraform" },
  sync_install = false,
  ignore_install = { "" },
  auto_install = true,
  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  },

  textobjects = require("rmagatti.treesitter-textobjects"),
  context_commentstring = require("rmagatti.treesitter-context-commentstring"),
  textsubjects = require("rmagatti.treesitter-textsubjects"),
  incremental_selection = require("rmagatti.treesitter-incremental-selection"),

  -- TODO: Figure out how to use move
  move = require("rmagatti.treesitter-move"),
}

-- TODO: enable when I need ejs
-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.ejs = {
--   install_info = {
--     url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
--     files = { "src/parser.c" },
--     requires_generate_from_grammar = true,
--   },
--   filetype = "ejs",
-- }

-- Reset treesitter
vim.cmd [[
  nnoremap <leader>rt <cmd>w <bar> e <bar> TSBufEnable highlight <bar> set syntax=off<CR>
]]
