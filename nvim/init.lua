require "impatient"
vim.g.mapleader = " "

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
vim.o.background = "dark"
vim.o.ts = 2
vim.o.sw = 2
vim.o.expandtab = true
vim.o.signcolumn = "yes"
vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,folds"

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
  " command! -nargs=? Fold :call Fold()
  " command! -nargs=? Unfold :call Unfold()

  " TODO: testing https://github.com/rmagatti/auto-session/issues/109
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set foldlevelstart=99
]]

-- Attempt to fix press enter message on starting Firenvim
if vim.g.started_by_firenvim == 1 then
  vim.g.auto_session_enabled = false
  vim.cmd [[set guifont=JetBrains_Mono:h18]]
end

-- load mappings
vim.cmd [[
  source $HOME/.config/nvim/mappings.vim
]]

function _G.delete_hidden_buffers(force)
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if vim.fn.buflisted(buffer) and vim.fn.bufwinnr(buffer) == -1 then
      if not force then
        vim.api.nvim_command("bwipeout " .. buffer)
      else
        vim.api.nvim_command("bwipeout! " .. buffer)
      end
    end
  end
end

vim.keymap.set("n", "<leader>cab", ":call v:lua.delete_hidden_buffers()<CR>")
vim.keymap.set("n", "<leader>cab!", ":call v:lua.delete_hidden_buffers(1)<CR>")

require "packer_compiled"
require "plugins"
