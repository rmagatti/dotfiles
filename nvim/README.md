## Neovim config

### Plugins
- 'tpope/vim-commentary'
- 'tpope/vim-surround'
- 'tpope/vim-fugitive'
- 'junegunn/fzf'
- 'neoclide/coc.nvim'
- 'neoclide/coc-tsserver'
- 'HerringtonDarkholme/yats.vim'
- 'dbeniamine/cheat.sh-vim'
- 'mbbill/undotree'
- 'morhetz/gruvbox'
- 'jremmen/vim-ripgrep'
- 'christoomey/vim-system-copy'
- 'ryanoasis/vim-devicons'
- 'wincent/vcs-jump'
- 'junegunn/goyo.vim'
- 'vim-test/vim-test'
- 'itchyny/lightline.vim'
- 'jiangmiao/auto-pairs'
- 'puremourning/vimspector'
- 'justinmk/vim-dirvish'
- 'tpope/vim-eunuch'

### Description
A Neovim configuration primarily targetting typescript development.

### Features
- Vscode-like code completion and navigation (coc.nvim + extensions)
- Ultra fast fuzzy file finding (fzf + fzf-preview)
- Git integration (fugitive + fzf-preview)
- Debugging (vimspector)

### coc extensions
- coc-yank
- coc-vimlsp
- coc-terminal
- coc-snippets
- coc-prettier
- coc-fzf-preview
- coc-tsserver
- coc-json


### Modules
- init.vim | Root of the config
- base.vim | Pure neovim configs
- plugins.vim | Plugin loading with plug
- mappings.vim | Pure neovim mappings
- plugin-mappings.vim | Plugin specific mappings
- coc-mappings.vim | coc.nvim mappings, most of where the functionality comes from
- plugin-settings.vim | Plugin specific settings
- coc-settings.json | :wrench:

