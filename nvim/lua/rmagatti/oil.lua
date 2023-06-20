local M = {}

function M.setup()
  require('oil').setup()

  vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
end

return M
