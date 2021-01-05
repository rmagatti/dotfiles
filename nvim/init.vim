if exists('g:vscode')
  " VSCode extension
else
  source $HOME/.config/nvim/base.vim
  source $HOME/.config/nvim/plugins.vim
  source $HOME/.config/nvim/mappings.vim
  source $HOME/.config/nvim/plugin-settings.vim
  source $HOME/.config/nvim/plugin-mappings.vim
endif
