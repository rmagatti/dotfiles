call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
" Plug 'ycm-core/YouCompleteMe'
Plug 'HerringtonDarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim' " TypeScript syntax
" Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'dbeniamine/cheat.sh-vim'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'christoomey/vim-system-copy'
Plug 'ryanoasis/vim-devicons'
Plug 'wincent/vcs-jump' " TODO: learn how to use this
Plug 'junegunn/goyo.vim'
Plug 'vim-test/vim-test'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'puremourning/vimspector'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-sneak'
call plug#end()

