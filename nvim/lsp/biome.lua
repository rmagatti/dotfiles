---@type vim.lsp.Config
return {
  settings = {
    capabilities = {
      documentFormattingProvider = true,
      documentRangeFormattingProvider = true,
      codeActionProvider = true,
    },
  }
}
