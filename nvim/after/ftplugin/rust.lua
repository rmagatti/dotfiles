local bufnr = vim.api.nvim_get_current_buf()

vim.lsp.inlay_hint.enable()

vim.keymap.set("n", "<leader>x", function()
  vim.cmd.RustLsp("explainError")
end, { silent = true })

vim.keymap.set(
  { "n", "x", "v" }, "<M-CR>",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
  end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set(
  "n",
  "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ 'hover', 'actions' })
  end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set(
  "n",
  "<J>",
  function()
    vim.cmd.RustLsp('joinLines')
  end,
  { silent = true, buffer = bufnr }
)
