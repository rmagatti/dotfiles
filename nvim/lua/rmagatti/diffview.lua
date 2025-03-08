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

vim.cmd [[
  nnoremap <leader>dvo :DiffviewOpen<CR>
  nnoremap <leader>dvc :DiffviewClose<CR>
]]
