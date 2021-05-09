call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'dbeniamine/cheat.sh-vim'
Plug 'mbbill/undotree'
Plug 'jremmen/vim-ripgrep'
" Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-test/vim-test'
" Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-autopairs'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-startify'
Plug 'unblevable/quick-scope'
Plug 'tommcdo/vim-exchange'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}
Plug 'michaeljsmith/vim-indent-object'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'heavenshell/vim-jsdoc', {'for': ['javascript', 'javascript.jsx','typescript'], 'do': 'make install' }

" " CoC
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
" Plug 'rafcamlet/coc-nvim-lua'

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'sindrets/diffview.nvim'
Plug 'ThePrimeagen/git-worktree.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'

" Completion
Plug 'hrsh7th/nvim-compe'
" Plug 'glepnir/lspsaga.nvim'

" Diagnostics
Plug 'folke/lsp-trouble.nvim'
Plug 'kosayoda/nvim-lightbulb'

" " Signatures
" Plug 'ray-x/lsp_signature.nvim'

" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'gbrlsnchs/telescope-lsp-handlers.nvim'

" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim'

" Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

" Rainbow parenthesis
Plug 'p00f/nvim-ts-rainbow'

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc' }

Plug 'hoob3rt/lualine.nvim'

" Terraform
Plug 'hashivim/vim-terraform'

" Text objects
Plug 'wellle/targets.vim'

" Symbols
Plug 'simrat39/symbols-outline.nvim'

" Typescript utils
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Quickfix
Plug 'kevinhwang91/nvim-bqf'

" Algning
Plug 'junegunn/vim-easy-align'

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'
" Plug 'rcarriga/nvim-dap-ui'

" Bufferize commands
Plug 'AndrewRadev/bufferize.vim'

" Plug 'ayu-theme/ayu-vim'
" Lazy
Plug 'sotte/presenting.vim', { 'on': 'PresentationStart'}
Plug 'puremourning/vimspector', {'on': '<Plug>VimspectorContinue'}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " <leader> keymap presentation

" Temporarily disabled, hanging Neovim on certain operations"
" Plug 'folke/which-key.nvim'

Plug 'dstein64/vim-startuptime'

" Local
Plug '~/Projects/auto-session'
Plug '~/Projects/alternate-toggler'
Plug '~/Projects/session-lens'
call plug#end()

