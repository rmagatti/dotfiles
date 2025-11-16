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
local font = "JetBrainsMono Nerd Font:h"

if vim.g.neovide then
  vim.opt.guifont = font .. tostring(12)
  vim.g.neovide_refresh_rate = 120

  vim.g.neovide_cursor_animation_length = 0.015
  vim.g.neovide_cursor_trail_length = 0.15
  vim.g.neovide_input_macos_option_key_is_meta = "both"
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
vim.opt.sessionoptions = { "blank", "buffers", "curdir", "help", "tabpages", "winsize", "winpos", "localoptions" }

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
vim.cmd [[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
  augroup end
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

require "rmagatti.lazy"
require "rmagatti.mappings"
require "rmagatti.folding"
require "rmagatti.rust-test-folding"
require "rmagatti.autocmds"

local original_notify = vim.notify

--- Override vim.notify to always log messages to the message log
---@diagnostic disable-next-line: duplicate-set-field
vim.notify = function(msg, level, opts)
  -- Always ensure messages go to the message log
  -- Use vim.api.nvim_echo for reliable message display
  local log_level = level or vim.log.levels.INFO

  -- Convert level to string if it's a number
  local level_name = type(log_level) == "number" and
      (log_level == vim.log.levels.ERROR and "ERROR" or
        log_level == vim.log.levels.WARN and "WARN" or
        log_level == vim.log.levels.INFO and "INFO" or
        "DEBUG") or tostring(log_level)

  -- Format message for the message log
  local formatted_msg = string.format("[%s] %s", level_name, msg)

  -- Add to message history using vim.api.nvim_echo
  vim.api.nvim_echo({ { formatted_msg, "Normal" } }, true, {})

  -- Also call original notify if it exists and isn't nil
  if original_notify and type(original_notify) == "function" then
    return original_notify(msg, level, opts)
  end
end
