call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'HerringtonDarkholme/yats.vim'
" Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'dbeniamine/cheat.sh-vim'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'christoomey/vim-system-copy'
Plug 'ryanoasis/vim-devicons'
Plug 'wincent/vcs-jump' " TODO: learn how to use this or remove!
Plug 'vim-test/vim-test'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-sneak'
Plug 'psliwka/vim-smoothie'      " some very smooth ass scrolling
" Lazy
Plug 'puremourning/vimspector', {'on': '<Plug>VimspectorContinue'}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
call plug#end()

