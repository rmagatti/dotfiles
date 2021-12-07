require("session-lens").setup {
  path_display = { "shorten" },
  theme_conf = { border = true },
  previewer = false,
}

vim.api.nvim_set_keymap(
  "n",
  "<C-s>",
  "<cmd>lua require('telescope').extensions['session-lens'].search_session()<CR>",
  { noremap = true }
)
