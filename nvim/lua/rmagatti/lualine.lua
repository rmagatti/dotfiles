require('lualine').setup{
  options = {
    theme = 'tokyonight',
  },
  extensions = { 'fzf', 'fugitive' },
  -- sections = {lualine_c = {require'lsp-status'.status}}
}
