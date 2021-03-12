call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'dbeniamine/cheat.sh-vim'
Plug 'mbbill/undotree'
" Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-test/vim-test'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch' " TODO: remove if unused!!
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-startify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'unblevable/quick-scope'
Plug 'tommcdo/vim-exchange'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}
Plug 'rafcamlet/coc-nvim-lua'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'heavenshell/vim-jsdoc', {'for': ['javascript', 'javascript.jsx','typescript'], 'do': 'make install' }

" Plug 'ayu-theme/ayu-vim'
" Lazy
Plug 'sotte/presenting.vim', { 'on': 'PresentationStart'}
Plug 'puremourning/vimspector', {'on': '<Plug>VimspectorContinue'}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " <leader> keymap presentation
" Local
Plug '~/Projects/auto-session'
Plug '~/Projects/alternate-toggler'
call plug#end()

