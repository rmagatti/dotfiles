local M = {}

M.setup = function()
  vim.g.skip_ts_context_commentstring_module = true
  require('ts_context_commentstring').setup {
    enable = true,
    enable_autocmd = false,
  }
end

return M
