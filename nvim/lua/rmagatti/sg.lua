local M = {}

M.setup = function()
  local on_attach = require("rmagatti.lsp.lsp-common").common_on_attach
  require("sg").setup {
    on_attach = on_attach,
    chat = {
      default_model="anthropic/claude-3-5-sonnet-20240620"
    }
  }

  vim.keymap.set("n", "<leader>sg", require("sg.extensions.telescope").fuzzy_search_results,
    { noremap = true, silent = true })
end

return M
