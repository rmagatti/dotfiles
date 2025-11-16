-- Autocmd to use lsp format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local clients = vim.lsp.get_clients { bufnr = 0 }
    for _, client in ipairs(clients) do
      if client:supports_method({ method = "textDocument/formatting", bufnr = 0 }) then
        vim.lsp.buf.format { bufnr = 0, async = false }
        return
      end
    end
  end,
})
