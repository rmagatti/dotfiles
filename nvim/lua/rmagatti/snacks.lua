---@diagnostic disable: lowercase-global
local M = {}

is_dimmed = false

M.setup = function()
  require("snacks").setup {
    indent = { enabled = false },
    input = { enabled = false },
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ["<C-i>"] = { "history_next", mode = { "i", "n" } },
            ["<C-o>"] = { "history_prev", mode = { "i", "n" } },
          },
        },
      },
    },
    dim = { enabled = true },
    notifier = { enabled = true },
    zen = { enabled = true }
  }

  vim.keymap.set("n", "<leader>zz", function()
    -- Toggle between dim and disable
    if is_dimmed then
      require("snacks").dim.disable()
      is_dimmed = false
    else
      require("snacks").dim()
      is_dimmed = true
    end
  end, { noremap = true, silent = true })

  -- Load picker mappings
  require("rmagatti.mappings.picker")
  
  -- Load custom pickers
  require("rmagatti.snacks.buffers").setup()
  require("rmagatti.snacks.dotfiles").setup()
end

return M
