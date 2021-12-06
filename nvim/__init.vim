if exists('g:vscode')
  " VSCode extension
else
  " source $HOME/.config/nvim/base.vim
  lua require('impatient')
  lua require('packer_compiled')
  lua require('plugins')
  lua require('init')
  source $HOME/.config/nvim/mappings.vim
endif
