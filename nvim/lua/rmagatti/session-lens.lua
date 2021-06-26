require('session-lens').setup {
  shorten_path = true,
  theme_conf = { border = true },
  previewer = false
}

vim.api.nvim_set_keymap('n', '<leader>ss', "<cmd>lua require('telescope').extensions['session-lens'].search_session()<CR>", {noremap=true})

