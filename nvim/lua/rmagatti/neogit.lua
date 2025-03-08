local prefix = "<localleader>"

require("neogit").setup {
  integrations = {
    -- diffview = true,
    telescope = true
  },
  use_default_keymaps = true,
  mappings = {
    popup = {
      ["L"] = "LogPopup"
    },
    status = {
      ["k"] = "MoveDown",
      ["l"] = "MoveUp",
    }
  }
}
vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', {})
