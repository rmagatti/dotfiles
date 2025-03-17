local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    winblend = 30,
    border = false,
    mappings = {
      -- Moved <c-i> <c-o> to normal mode and disabled escape closing the picker directly.
      -- Turns out <c-i> was interfering with the tab behaviour of selecting entries
      i = {
        -- ["<esc>"] = actions.close,
        -- ["<Tab>"] = require("telescope.actions").toggle_selection
      },
      n = {
        ["<C-i>"] = require("telescope.actions").cycle_history_next,
        ["<C-o>"] = require("telescope.actions").cycle_history_prev,
      }
    },
  }
}

require("telescope").load_extension "fzf"
require("rmagatti.telescope.buffers").setup()
require("rmagatti.telescope.dotfiles").setup()
require "rmagatti.telescope.mappings"
