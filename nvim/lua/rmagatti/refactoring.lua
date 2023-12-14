local M = {}

function M.setup()
  require("refactoring").setup {}
  require("telescope").load_extension "refactoring"

  -- remap to open the Telescope refactoring menu in visual mode
  vim.keymap.set("v", "<C-r>", require("telescope").extensions.refactoring.refactors, { noremap = true })
end

return M
