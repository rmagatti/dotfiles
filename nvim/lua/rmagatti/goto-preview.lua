require("goto-preview").setup {
  default_mappings = true,
  resizing_mappings = true,
  winblend = 10,
  debug = false,
}
-- Mapping to cycle between windows
vim.cmd [[nnoremap <C-h> <C-w>w]]
-- "Peek" mapping
vim.api.nvim_set_keymap(
  "n",
  "<leader>pk",
  "<cmd>lua require('goto-preview').goto_preview_definition(false, true)<CR>",
  { noremap = true }
)
