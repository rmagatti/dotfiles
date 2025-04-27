local M = {}

function M.setup()
  require('oil').setup {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      natural_order = true,
    },

    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-x>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      -- ["<C-p>"] = "actions.preview",
      -- ["<C-c>"] = "actions.close",
      -- ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
    use_default_keymaps = true,
  }

  vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
end

return M
