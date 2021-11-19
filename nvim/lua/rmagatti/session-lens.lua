require("session-lens").setup {
  path_display = { "shorten" },
  theme_conf = { border = true },
  previewer = false,
}

vim.api.nvim_set_keymap(
  "n",
  "<leader>ss",
  "<cmd>lua require('telescope').extensions['session-lens'].search_session()<CR>",
  { noremap = true }
)
