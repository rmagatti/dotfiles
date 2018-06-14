" dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/ronnie/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/ronnie/.cache/dein')
  call dein#begin('/Users/ronnie/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/ronnie/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/denite.nvim')
  call dein#add('tpope/vim-rails')
  call dein#add('kana/vim-textobj-user')
  call dein#add('nelstrom/vim-textobj-rubyblock')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

 " If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" End dein Scripts-------------------------

" -------- Configs --------
:set relativenumber
