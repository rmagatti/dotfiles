if exists('g:vscode')
  " VSCode extension
else
  source $HOME/.config/nvim/base.vim
  lua require('impatient') -- Faster startup
  lua require('plugins')
  lua require('init')
  source $HOME/.config/nvim/mappings.vim
endif
