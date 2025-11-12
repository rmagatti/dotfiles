-- Minimal init file for running tests
-- This loads only the essential plugins needed for testing

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/testing/start/plenary.nvim"

-- Install plenary if not available
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/nvim-lua/plenary.nvim",
    install_path,
  })
  vim.cmd("packadd plenary.nvim")
end

-- Set up treesitter if available
local treesitter_path = fn.stdpath("data") .. "/site/pack/testing/start/nvim-treesitter"
if fn.empty(fn.glob(treesitter_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    treesitter_path,
  })
end

-- Add the project root to runtimepath so we can require the module
local project_root = vim.fn.fnamemodify(vim.fn.expand("<sfile>"), ":h:h")
vim.opt.runtimepath:append(project_root)

-- Basic options for testing
vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.termguicolors = true

-- Load treesitter with rust parser
pcall(function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "rust", "lua" },
    sync_install = true,
    auto_install = false,
    highlight = {
      enable = true,
    },
  })
end)

-- Set up folding options for tests
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false -- Don't fold by default

-- Make sure we can require the module under test
package.path = package.path .. ";" .. project_root .. "/lua/?.lua"
package.path = package.path .. ";" .. project_root .. "/lua/?/init.lua"

-- Disable some features that might interfere with tests
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1

-- Set up test environment
vim.env.PLENARY_TEST_TIMEOUT = 10000
