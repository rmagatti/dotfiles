---@type vim.lsp.Config
return {
  capabilities = {
    formatting = false,
    documentHighlightProvider = true,
    -- Offloading formatting to biomejs
    documentFormattingProvider = false,
    documentRangeFormattingProvider = false,
  },
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
