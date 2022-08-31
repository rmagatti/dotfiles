require "impatient"
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.encoding = "UTF-8"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false

vim.opt.mouse = "a"
-- set shada (print shada file contents)
-- if vim.g.started_by_firenvim then
--   vim.opt.guifont = "JetBrains Mono:18"
-- end

if vim.g.neovide then
  vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h12"
  -- vim.opt.guifont = "JetBrains Mono:h12,FiraCode Nerd Font Mono:h12,Hack:h12,JetBrainsMono Nerd Font Mono:h12"
  -- vim.opt.guifontwide = "JetBrains Mono:h12,FiraCode Nerd Font Mono Regular:h12,Hack:h12,JetBrainsMono Nerd Font Mono Regular:h12"

  vim.g.neovide_cursor_animation_length = 0.015
  vim.g.neovide_cursor_trail_length = 0.15
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_floating_blur_amount_x = 3.0
  vim.g.neovide_floating_blur_amount_y = 3.0

  -- Allow clipboard copy paste in Neovide
  vim.g.neovide_input_use_logo = 1
  -- vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
  -- vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  -- vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  -- vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
end

vim.opt.background = "dark"
vim.opt.ts = 2
vim.opt.sw = 2
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.sessionoptions = { "blank", "buffers", "curdir", "help", "tabpages", "winsize", "winpos" }

-- " performance tweaks
vim.opt.cursorline = false
vim.opt.cursorcolumn = false
vim.opt.scrolljump = 5
-- set lazyredraw
-- set ttyfast
vim.opt.redrawtime = 3000
-- set synmaxcol=180
-- set re=1

vim.opt.hidden = true
vim.opt.syntax = "on"

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Give more space for displaying messages.
vim.opt.cmdheight = 3

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Don't pass messages to |ins-completion-menu|.
-- Show search match counter
vim.opt.shortmess = "filnxtToOFc"

vim.opt.emoji = true
vim.opt.undofile = true

vim.g.undodir = vim.fn.stdpath "data" .. "/undodir"
-- let &undodir = expand(stdpath('data')."/undodir")
vim.opt.grepprg = "rg"
--to get rid of display of last command
vim.opt.showcmd = true

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
  vim.opt.termguicolors = true
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

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true

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

-- -- Attempt to fix press enter message on starting Firenvim
-- if vim.g.started_by_firenvim == 1 then
--   vim.g.auto_session_enabled = false
--   vim.cmd [[set guifont=JetBrains_Mono:h18]]
-- end

-- load mappings
vim.cmd [[
  source $HOME/.config/nvim/mappings.vim
]]

-- -- TODO: this mappingg isn't working, conflicts with global toggleterm mapping, fix it
-- vim.keymap.set('t', [[<C-_>]], [[<C-\><C-n>]], { noremap = true })

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
