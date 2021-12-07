require "impatient"
require "plugins"
require "packer_compiled"

vim.o.relativenumber = true
vim.o.number = true
vim.o.encoding = "UTF-8"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.swapfile = false

vim.o.mouse = "a"
-- set shada
-- Goneovim options TODO: figure out a way to no repeat font name for presentation mode
vim.o.guifont = "JetBrains_Mono:12"
vim.g.mapleader = " "
vim.o.background = "dark"
vim.o.ts = 2
vim.o.sw = 2
vim.o.expandtab = true
vim.o.signcolumn = "yes"
vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"

-- " performance tweaks
vim.o.cursorline = false
vim.o.cursorcolumn = false
vim.o.scrolljump = 5
-- set lazyredraw
-- set ttyfast
vim.o.redrawtime = 3000
-- set synmaxcol=180
-- set re=1

vim.o.hidden = true
vim.o.syntax = "on"

-- Some servers have issues with backup files, see #649.
vim.o.backup = false
vim.o.writebackup = false

-- Give more space for displaying messages.
vim.o.cmdheight = 3

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 300

-- Don't pass messages to |ins-completion-menu|.
-- Show search match counter
vim.o.shortmess = "filnxtToOFc"

vim.o.emoji = true
vim.o.undofile = true

vim.g.undodir = vim.fn.stdpath "data" .. "/undodir"
-- let &undodir = expand(stdpath('data')."/undodir")
vim.o.grepprg = "rg"
--to get rid of display of last command
vim.o.showcmd = true

-- Store global vars in sessions
-- set sessionoptions+=globals
-- set viminfo+=!

-- Plugin configs
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.cmd [[
  augroup annoying
    au!
    au BufEnter * set fo-=c fo-=r fo-=o                     " stop annoying auto commenting on new lines
  augroup end
]]

if vim.fn.has "termguicolors" then
  vim.o.termguicolors = true
end

-- Custom autocmds
vim.cmd [[
augroup goyocmds
  autocmd!
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!

augroup end
]]

vim.cmd [[
augroup AutoAdjustResize
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup end
]]

-- Presentation Mode
vim.g.in_presentation_mode = 0

vim.cmd [[
function! TogglePresentationMode()
  if g:in_presentation_mode
    let g:in_presentation_mode = 0
    set guifont=FiraCode\ Nerd\ Font:h12
    Goyo!
  else
    let g:in_presentation_mode = 1
    set guifont=FiraCode\ Nerd\ Font:h30
    " Default Goyo options, just need to use them since I don't want the toggling behaviour to trigger at all.
    Goyo 80x85%
  endif
endfunction
]]

vim.cmd [[command! TogglePresentationMode :call TogglePresentationMode()<CR>]]

vim.cmd [[
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup end
]]

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.o.foldenable = true

-- Protip: zi toggles folding
vim.cmd [[
  function! Fold()
    set foldenable
    " normal zM
  endfunction

  function! Unfold()
    " normal zR
    set nofoldenable
  endfunction
]]

-- Add `:Fold` command to fold current buffer.
vim.cmd [[
  command! -nargs=? Fold :call Fold()
  command! -nargs=? Unfold :call Unfold()
]]

-- Attempt to fix press enter message on starting Firenvim
if vim.g.started_by_firenvim == 1 then
  vim.g.auto_session_enabled = false
end

--" Figure out if I'll use this or not
-- function! s:CompareQuickfixEntries(i1, i2)
--   if bufname(a:i1.bufnr) == bufname(a:i2.bufnr)
--     return a:i1.lnum == a:i2.lnum ? 0 : (a:i1.lnum < a:i2.lnum ? -1 : 1)
--   else
--     return bufname(a:i1.bufnr) < bufname(a:i2.bufnr) ? -1 : 1
--   endif
-- endfunction

-- function! s:SortUniqQFList()
--   let sortedList = sort(getqflist(), 's:CompareQuickfixEntries')
--   let uniqedList = []
--   let last = ''
--   for item in sortedList
--     let this = bufname(item.bufnr) . "\t" . item.lnum
--     if this !=# last
--       call add(uniqedList, item)
--       let last = this
--     endif
--   endfor
--   call setqflist(uniqedList)
-- endfunction
-- autocmd! QuickfixCmdPost * call s:SortUniqQFList()

-- load mappings
vim.cmd [[
  source $HOME/.config/nvim/mappings.vim
]]
