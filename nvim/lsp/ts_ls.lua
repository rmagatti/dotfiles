---@type vim.lsp.Config
return {
  capabilities = {
    formatting = false,
    documentHighlightProvider = true,
    -- Offloading formatting to biomejs
    documentFormattingProvider = false,
    documentRangeFormattingProvider = false,
    codeActionProvider = true,
  },
  settings = {
    -- Project-wide diagnostics (equivalent to VS Code's
    -- js/ts.tsserver.experimental.enableProjectDiagnostics)
    tsserver = {
      experimental = {
        enableProjectDiagnostics = true,
      },
    },
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
    javascript = {
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
