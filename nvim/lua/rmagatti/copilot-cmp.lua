local M = {}

function M.setup()
  require("copilot_cmp").setup {
    formatters = {
      insert_text = require("copilot_cmp.format").remove_existing,
    },
    fix_pairs = true,
  }

  require("lspkind").init {
    symbol_map = {
      Copilot = "",
    },
  }

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end

return M
