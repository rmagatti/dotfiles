local emit = require("diffview").emit

require("diffview").setup {
  diff_binaries = false, -- Show diffs for binaries
  use_icons = true,      -- Requires nvim-web-devicons
  file_panel = {
    win_config = {
      width = 35,
    }
  },
  key_bindings = {
    -- The `view` bindings are active in the diff buffers, only when the current
    view = {},
    file_panel = {
      ["j"] = false,
      ["k"] = function() require("diffview.actions").next_entry() end,
      ["l"] = function() require("diffview.actions").prev_entry() end,
      [";"] = function() require("diffview.actions").select_entry() end,
      ["<CR>"] = function() require("diffview.actions").select_entry() end,
    },
  },
}

vim.keymap.set("n", "<leader>dvo", "<cmd>DiffviewOpen<CR>", { desc = "Diffview open" })
vim.keymap.set("n", "<leader>dvc", "<cmd>DiffviewClose<CR>", { desc = "Diffview close" })
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Diffview file history" })
