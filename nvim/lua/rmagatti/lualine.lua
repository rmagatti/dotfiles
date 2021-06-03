require('lualine').setup{
  options = {
    theme = 'tokyonight',
  },
  extensions = { 'fzf', 'fugitive' },
  sections = {lualine_a = {require'lsp-status'.status}}
}
