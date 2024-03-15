vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = ","
-- Global Statusline
vim.opt.laststatus = 3
-- Winbar per buffer with the filename and modified status
vim.opt.winbar = [[%=%m %f]]

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.encoding = "UTF-8"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false

vim.opt.mouse = "a"
-- set shada (print shada file contents)
local font = "JetBrainsMono Nerd Font:h"

if vim.g.neovide then
  vim.opt.guifont = font .. tostring(12)
  vim.g.neovide_refresh_rate = 120

  vim.g.neovide_cursor_animation_length = 0.015
  vim.g.neovide_cursor_trail_length = 0.15
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_floating_blur_amount_x = 3.0
  vim.g.neovide_floating_blur_amount_y = 3.0
  vim.g.neovide_underline_stroke_scale = 1
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_padding_top = 0

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  -- Allow clipboard copy paste in Neovide
  vim.g.neovide_input_use_logo = 1
  -- vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
  -- vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  -- vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  -- vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

  local function increment_font_size()
    local curr_font = vim.o.guifont
    local size = tostring(tonumber(curr_font:match "h(%d+)") + 1)

    vim.o.guifont = font .. size
  end

  local function decrement_font_size()
    local curr_font = vim.o.guifont
    local size = tostring(tonumber(curr_font:match "h(%d+)") - 1)

    vim.o.guifont = font .. size
  end

  vim.keymap.set("n", "<D-=>", increment_font_size, { noremap = true, silent = true })
  vim.keymap.set("n", "<D-->", decrement_font_size, { noremap = true, silent = true })
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

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
-- vim.opt.updatetime = 300

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
    normal zM
  endfunction

  function! Unfold()
    normal zR
  endfunction
]]

local function Fold()
  vim.cmd [[normal zM]]
end

local function Unfold()
  vim.cmd [[normal zR]]
end

vim.api.nvim_create_user_command("Fold", Fold, { desc = "Fold current buffer", nargs = "?" })
vim.api.nvim_create_user_command("Unfold", Unfold, { desc = "Unfold current buffer", nargs = '?' })

-- load mappings
vim.cmd [[
  source $HOME/.config/nvim/mappings.vim
]]

vim.opt.syntax = "off"

require "plugins"
require "rmagatti.mappings"
