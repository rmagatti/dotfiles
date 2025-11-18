require("mason-lspconfig").setup {
  automatic_enable = {
    exclude = {
      "rust_analyzer",
      "ts_ls"
    }
  }
}
