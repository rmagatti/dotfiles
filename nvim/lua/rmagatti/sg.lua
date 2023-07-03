local on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

local M = {}

M.setup = function()
  require("sg").setup {
    on_attach = on_attach,
  }

  vim.keymap.set("n", "<leader>sg", require("sg.extensions.telescope").fuzzy_search_results, { noremap = true, silent = true })
end

return M
