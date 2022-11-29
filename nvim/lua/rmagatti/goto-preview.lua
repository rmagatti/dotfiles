require("goto-preview").setup {
  default_mappings = true,
  resizing_mappings = true,
  winblend = 10,
  debug = false,
}
-- Mapping to cycle between windows
-- TODO: remove me after testing out vim.keymap.set
-- vim.cmd [[nnoremap <C-h> <C-w>w]]
vim.keymap.set("n", "<C-h>", "<C-w>w")
vim.keymap.set("n", "<leader>pk", "<cmd>lua require('goto-preview').goto_preview_definition(false, true)<CR>")

-- "Peek" mapping
-- TODO: remove me after testing out vim.keymap.set
vim.api.nvim_set_keymap(
  "n",
  "L", -- for "look"
  "<cmd>lua require('goto-preview').goto_preview_definition({focus_on_open=false, dismiss_on_move=true})<CR>",
  { noremap = true }
)
