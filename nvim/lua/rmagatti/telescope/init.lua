local actions = require "telescope.actions"

-- require("telescope").setup {
--   defaults = {
--     vimgrep_arguments = {
--       "rg",
--       "--color=never",
--       "--no-heading",
--       "--with-filename",
--       "--line-number",
--       "--column",
--       "--smart-case",
--     },
--     prompt_prefix = "> ",
--     selection_caret = "> ",
--     entry_prefix = "  ",
--     initial_mode = "insert",
--     selection_strategy = "reset",
--     sorting_strategy = "descending",
--     layout_strategy = "horizontal",
--     layout_config = {
--       horizontal = {
--         mirror = false,
--       },
--       vertical = {
--         mirror = false,
--       },
--     },
--     file_sorter = require("telescope.sorters").get_fuzzy_file,
--     file_ignore_patterns = {
--       "node_modules",
--     },
--     generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
--     winblend = 30,
--     borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
--     border = false,
--     color_devicons = true,
--     use_less = true,
--     set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
--     file_previewer = require("telescope.previewers").vim_buffer_cat.new,
--     grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
--     qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
--     mappings = {
--       i = {
--         -- Close on first esc instead of going to normal mode
--         ["<esc>"] = actions.close,
--         ["<C-i>"] = require("telescope.actions").cycle_history_next,
--         ["<C-o>"] = require("telescope.actions").cycle_history_prev,
--       },
--     },
--     pickers = {
--       lsp_dynamic_workspace_symbols = {
--         theme = require("telescope.themes").get_cursor({}),
--         previewer = true,
--         sorter = require("telescope").extensions.fzf.native_fzf_sorter({
--           fuzzy = true,
--           override_file_sorter = true,
--           override_generic_sorter = true,
--           case_mode = "smart_case",
--         })
--       },
--       git_files = {
--         theme = require("telescope.themes").get_cursor({}),
--       }
--     },
--     extensions = {
--       fzf = {
--         fuzzy = true,
--         override_generic_sorter = true, -- override the generic sorter
--         override_file_sorter = true, -- override the file sorter
--         case_mode = "smart_case", -- or "ignore_case" or "respect_case"
--       },
--       -- ["ui-select"] = {
--       --   require("telescope.themes").get_cursor {},
--       -- },
--     },
--   },
-- }
-- TODO: Testing out new telescope config passing less things

require("telescope").setup {
  defaults = {
    winblend = 30,
    border = false,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-i>"] = require("telescope.actions").cycle_history_next,
        ["<C-o>"] = require("telescope.actions").cycle_history_prev,
      },
    },
  }
}

require("telescope").load_extension "fzf"
require("rmagatti.telescope.buffers").setup()
require("rmagatti.telescope.dotfiles").setup()
require "rmagatti.telescope.mappings"
require("telescope").load_extension "session-lens"
