local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    mappings = {
      i = {
        -- Close on first esc instead of going to normal mode
        ["<esc>"] = actions.close,
        ["<C-i>"] = require("telescope.actions").cycle_history_next,
        ["<C-o>"] = require("telescope.actions").cycle_history_prev,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_cursor {},
      },
    },
  },
}

require("rmagatti.telescope.buffers").setup()
require("rmagatti.telescope.dotfiles").setup()
require("rmagatti.telescope.session-lens").setup()

vim.keymap.set(
  "n",
  "<D-f>",
  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy())<CR>"
)
vim.keymap.set("n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<CR>")
vim.keymap.set("n", "<C-f>", "<cmd>lua require('telescope.builtin').find_files()<CR>")
vim.keymap.set("n", "<leader>ps", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
vim.keymap.set(
  "n",
  "<leader>pg",
  "<cmd>lua require('telescope.builtin').grep_string({search=vim.fn.input('Search: ')})<CR>"
)
vim.keymap.set("n", "<leader>wt", "<cmd>lua require('telescope.extensions').git_worktree.git_worktrees()<CR>")
vim.keymap.set("n", "<C-b>", require("telescope.builtin").git_branches)
