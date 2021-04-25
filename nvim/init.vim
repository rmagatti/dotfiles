if exists('g:vscode')
  " VSCode extension
else
  source $HOME/.config/nvim/base.vim
  source $HOME/.config/nvim/plugins.vim
  source $HOME/.config/nvim/mappings.vim
  lua require('init')
endif
