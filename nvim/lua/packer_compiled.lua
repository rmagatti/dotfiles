-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/ronnieandrewmagatti/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/ronnieandrewmagatti/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/ronnieandrewmagatti/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/ronnieandrewmagatti/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/ronnieandrewmagatti/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["alternate-toggler"] = {
    config = { "\27LJ\2\n˜\1\0\0\6\0\t\0\r6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0002 let g:at_custom_alternates = {'===': '!=='} \bcmd\1\0\1\fnoremap\2X<cmd>lua require('alternate-toggler').toggleAlternate(vim.fn.expand('<cword>'))<CR>\20<leader><space>\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/alternate-toggler",
    url = "/Users/ronnieandrewmagatti/Projects/alternate-toggler"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26rmagatti.auto-session\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "/Users/ronnieandrewmagatti/Projects/auto-session"
  },
  ["bufferize.vim"] = {
    commands = { "Bufferize" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/bufferize.vim",
    url = "https://github.com/AndrewRadev/bufferize.vim"
  },
  ["cheat.sh-vim"] = {
    commands = { "Cheat", "CheatPaste" },
    keys = { { "n", "<leader>KB" }, { "n", "<leader>KK" }, { "n", "<leader>KP" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cheat.sh-vim",
    url = "https://github.com/dbeniamine/cheat.sh-vim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-npm"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fcmp-npm\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-npm",
    url = "https://github.com/David-Kunz/cmp-npm"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-rg"] = {
    after_files = { "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-rg/after/plugin/cmp-rg.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-rg",
    url = "https://github.com/lukas-reineke/cmp-rg"
  },
  ["cmp-vsnip"] = {
    after_files = { "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-vsnip/after/plugin/cmp_vsnip.vim" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["copilot.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22rmagatti.diffview\frequire\0" },
    keys = { { "", "<leader>ddo" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  firenvim = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22rmagatti.firenvim\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/firenvim",
    url = "https://github.com/glacambre/firenvim"
  },
  ["friendly-snippets"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  fzf = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    load_after = {
      ["nvim-bqf"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22rmagatti.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["goto-preview"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26rmagatti.goto-preview\frequire\0" },
    keys = { { "n", "gpd" }, { "n", "gpi" }, { "n", "gpr" }, { "n", "gP" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/goto-preview",
    url = "/Users/ronnieandrewmagatti/Projects/goto-preview"
  },
  ["igs.nvim"] = {
    config = { "\27LJ\2\nJ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\21default_mappings\2\nsetup\bigs\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/igs.nvim",
    url = "/Users/ronnieandrewmagatti/Projects/igs.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lightspeed.nvim"] = {
    config = { "\27LJ\2\nÖ\2\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\a\25grey_out_search_area\2+match_only_the_start_of_same_char_seqs\2\21limit_ft_matches\3\5\30full_inclusive_prefix_key\n<c-x>\24jump_to_first_match\2)jump_on_partial_input_safety_timeout\3ê\3\27highlight_unique_chars\1\nsetup\15lightspeed\frequire\0" },
    keys = { { "n", "s" }, { "n", "S" }, { "n", "f" }, { "n", "F" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lsp-trouble.nvim"] = {
    commands = { "LspTrouble" },
    config = { "\27LJ\2\nu\0\0\3\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\2\5\0B\0\2\1K\0\1\0,nnoremap <leader>xx <cmd>LspTrouble<CR>\bcmd\bvim\nsetup\ftrouble\frequire\0" },
    keys = { { "", "<leader>xx" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/lsp-trouble.nvim",
    url = "https://github.com/folke/lsp-trouble.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21rmagatti.lualine\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "\27LJ\2\nô\1\0\0\4\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0(nnoremap <leader>gg <cmd>Neogit<CR>\bcmd\bvim\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0" },
    keys = { { "n", "<leader>gg" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28rmagatti.nvim-autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    after = { "fzf.vim" },
    config = { "\27LJ\2\nE\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16auto_enable\2\nsetup\bbqf\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    after = { "cmp-npm", "cmp-rg", "cmp-nvim-lsp", "cmp-buffer", "cmp-cmdline", "cmp-nvim-lua", "cmp-path", "cmp-vsnip" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22rmagatti.nvim-cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-virtual-text", "nvim-dap-ui", "telescope-dap.nvim" },
    config = { "\27LJ\2\na\0\0\3\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\1K\0\1\0\17rmagatti.dap\bdap\19load_extension\14telescope\frequire\0" },
    keys = { { "n", "<leader>db" }, { "n", "<leader>dB" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rmagatti.dap.dap-ui\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lightbulb"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28rmagatti.nvim-lightbulb\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-lightbulb",
    url = "https://github.com/kosayoda/nvim-lightbulb"
  },
  ["nvim-lsp-installer"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17rmagatti.lsp\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils",
    url = "https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\n¡\1\0\0\3\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0'\2\6\0B\0\2\1K\0\1\0Vnnoremap <leader>y <cmd>lua require('telescope').extensions.neoclip.default()<CR>\bcmd\bvim\1\0\1\30enable_persistant_history\2\nsetup\fneoclip\frequire\0" },
    keys = { { "n", "<leader>y" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-toggleterm.lua"] = {
    commands = { "ToggleTerm", "ToggleTermOpenAll", "ToggleTermCloseAll" },
    config = { "\27LJ\2\nU\0\1\2\0\3\0\f9\1\0\0\a\1\1\0X\1\3Ä)\1\25\0L\1\2\0X\1\5Ä9\1\0\0\a\1\2\0X\1\2Ä)\1P\0L\1\2\0K\0\1\0\rvertical\15horizontal\14directionË\5\1\0\a\0\28\00096\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0003\4\4\0=\4\5\3B\1\2\0016\1\6\0009\1\a\0019\1\b\1'\3\t\0'\4\n\0'\5\v\0005\6\f\0B\1\5\0016\1\6\0009\1\a\0019\1\b\1'\3\t\0'\4\r\0'\5\14\0005\6\15\0B\1\5\0016\1\6\0009\1\a\0019\1\b\1'\3\t\0'\4\16\0'\5\17\0005\6\18\0B\1\5\0016\1\6\0009\1\a\0019\1\b\1'\3\t\0'\4\19\0'\5\20\0005\6\21\0B\1\5\0016\1\6\0009\1\a\0019\1\b\1'\3\t\0'\4\22\0'\5\23\0005\6\24\0B\1\5\0016\1\6\0009\1\a\0019\1\b\1'\3\t\0'\4\25\0'\5\26\0005\6\27\0B\1\5\1K\0\1\0\1\0\1\fnoremap\2.<cmd>4ToggleTerm direction='vertical'<CR>\15<leader>4v\1\0\1\fnoremap\2.<cmd>3ToggleTerm direction='vertical'<CR>\15<leader>3v\1\0\1\fnoremap\2.<cmd>2ToggleTerm direction='vertical'<CR>\15<leader>2v\1\0\1\fnoremap\0020<cmd>4ToggleTerm direction='horizontal'<CR>\15<leader>4s\1\0\1\fnoremap\0020<cmd>3ToggleTerm direction='horizontal'<CR>\15<leader>3s\1\0\1\fnoremap\0020<cmd>2ToggleTerm direction='horizontal'<CR>\15<leader>2s\6n\20nvim_set_keymap\bapi\bvim\tsize\0\1\0\3\20start_in_insert\1\20insert_mappings\2\17open_mapping\n<c-\\>\nsetup\15toggleterm\frequire\0" },
    keys = { { "n", "<C-\\>" }, { "i", "<C-\\>" }, { "n", "<leader>2s" }, { "n", "<leader>3s" }, { "n", "<leader>4s" }, { "n", "<leader>2v" }, { "n", "<leader>3v" }, { "n", "<leader>4v" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-toggleterm.lua",
    url = "https://github.com/akinsho/nvim-toggleterm.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rmagatti.treesitter\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31rmagatti.nvim-web-devicons\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["refactoring.nvim"] = {
    config = { "\27LJ\2\n∏\1\0\0\6\0\t\0\f6\0\0\0'\2\1\0B\0\2\0016\0\2\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0005\5\b\0B\0\5\1K\0\1\0\1\0\3\vsilent\2\fnoremap\2\texpr\2)<cmd>call v:lua.list_refactors()<CR>\15<leader>re\6v\20nvim_set_keymap\bapi\bvim\25rmagatti.refactoring\frequire\0" },
    keys = { { "v", "<leader>re" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/refactoring.nvim",
    url = "https://github.com/ThePrimeagen/refactoring.nvim"
  },
  ["session-lens"] = {
    config = { "\27LJ\2\ns\0\0\3\0\5\0\n6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0'\2\4\0B\0\2\1K\0\1\0\17session-lens\19load_extension\14telescope\26rmagatti.session-lens\frequire\0" },
    keys = { { "", "<leader>ss" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/session-lens",
    url = "/Users/ronnieandrewmagatti/Projects/session-lens"
  },
  sniprun = {
    commands = { "SnipRun" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/sniprun",
    url = "https://github.com/michaelb/sniprun"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/tami5/sqlite.lua"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    config = { "\27LJ\2\ni\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\27highlight_hovered_item\2\16show_guides\2\nsetup\20symbols-outline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["targets.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-dap.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bdap\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-packer.nvim"] = {
    config = { "\27LJ\2\n±\1\0\0\3\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\4\0009\0\5\0'\2\6\0B\0\2\1K\0\1\0Rnnoremap <leader>pl :lua require('telescope').extensions.packer.plugins()<CR>\bcmd\bvim\vpacker\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/telescope-packer.nvim",
    url = "https://github.com/nvim-telescope/telescope-packer.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    config = { "\27LJ\2\nN\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\14ui-select\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/telescope-ui-select.nvim",
    url = "/Users/ronnieandrewmagatti/Projects/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    after = { "telescope-packer.nvim", "telescope-fzf-native.nvim", "telescope-ui-select.nvim" },
    commands = { "Telescope" },
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23rmagatti.telescope\frequire\0" },
    keys = { { "n", "<C-p>" }, { "n", "<leader>ps" }, { "n", "<leader>pg" }, { "n", "<leader>pl" }, { "n", "<leader>b" }, { "n", "<M-CR>" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    commands = { "TodoQuickFix", "TodoTrouble", "TodoTelescope" },
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rmagatti.tokyonight\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  undotree = {
    config = { "\27LJ\2\nH\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0)nnoremap <leader>u :UndotreeShow<CR>\bcmd\bvim\0" },
    keys = { { "", "<leader>u" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-commentary"] = {
    keys = { { "n", "gc" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-dirvish"] = {
    config = { "\27LJ\2\n≥\2\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0ì\2      command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish\n      command! VLeftDirvishFile leftabove vsplit | vertical resize 50 | silent Dirvish %\n      nnoremap <leader>fs :VLeftDirvish<CR>\n      nnoremap <leader>ff :VLeftDirvishFile<CR>\n      \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-dirvish",
    url = "https://github.com/justinmk/vim-dirvish"
  },
  ["vim-dirvish-dovish"] = {
    config = { "\27LJ\2\nπ\a\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0ô\a        let g:dirvish_dovish_map_keys = 0\n\n        augroup dirvish_config\n        autocmd!\n        \" unmap dirvish default\n        autocmd FileType dirvish silent! unmap <buffer><C-p>\n        autocmd FileType dirvish silent! unmap <buffer>p\n\n        \" My mappings\n        autocmd FileType dirvish silent! map <buffer>i <Plug>(dovish_create_file)\n        autocmd FileType dirvish silent! map <buffer>I <Plug>(dovish_create_directory)\n        autocmd FileType dirvish silent! map <buffer>dd <Plug>(dovish_delete)\n        autocmd FileType dirvish silent! map <buffer>r <Plug>(dovish_rename)\n        autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)\n        autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)\n        autocmd FileType dirvish silent! map <buffer>p <Plug>(dovish_copy)\n        autocmd FileType dirvish silent! map <buffer>P <Plug>(dovish_move)\n        augroup END\n      \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-dirvish-dovish",
    url = "https://github.com/roginfarrer/vim-dirvish-dovish"
  },
  ["vim-dirvish-git"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-dirvish-git",
    url = "https://github.com/kristijanhusak/vim-dirvish-git"
  },
  ["vim-easy-align"] = {
    commands = { "EasyAlign" },
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23rmagatti.easyalign\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-exchange"] = {
    keys = { { "n", "cx" }, { "x", "X" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-exchange",
    url = "https://github.com/tommcdo/vim-exchange"
  },
  ["vim-fugitive"] = {
    commands = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gvdiffsplit" },
    config = { "\27LJ\2\nﬁ\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0æ\1        nnoremap <silent> <leader>gb :<C-u>Git blame<CR>\n        nnoremap <leader>gd :Gvdiffsplit!<CR>\n        nnoremap gj :diffget //2<CR>\n        nnoremap g; :diffget //3<CR>\n        \bcmd\bvim\0" },
    keys = { { "n", "<leader>gd" }, { "n", "<leader>gb" }, { "n", "<leader>hp" }, { "n", "<leader>hs" }, { "n", "<leader>hu" }, { "n", "<leader>hr" }, { "n", "<leader>hR" }, { "n", "<leader>hp" }, { "n", "<leader>hb" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-grepper"] = {
    commands = { "Grepper", "<Plug>(GrepperOperator)" },
    config = { "\27LJ\2\nz\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0[        nmap gs <Plug>(GrepperOperator)\n        xmap gs <Plug>(GrepperOperator)\n      \bcmd\bvim\0" },
    keys = { { "n", "gs" }, { "x", "gs" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-grepper",
    url = "https://github.com/mhinz/vim-grepper"
  },
  ["vim-jsdoc"] = {
    commands = { "JsDoc" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-jsdoc",
    url = "https://github.com/heavenshell/vim-jsdoc"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-ripgrep"] = {
    commands = { "Rg" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-ripgrep",
    url = "https://github.com/jremmen/vim-ripgrep"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    config = { "vim.g.startuptime_tries = 10" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-surround"] = {
    keys = { { "n", "cs" }, { "n", "ds" }, { "x", "S" }, { "n", "ys" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-terraform"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-terraform",
    url = "https://github.com/hashivim/vim-terraform"
  },
  ["vim-test"] = {
    config = { "\27LJ\2\n©\t\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0â\t      let g:test#javascript#mocha#file_pattern = '\\v(tests?/.*|(test))\\.(js|jsx|coffee|ts)$'\n      let test#javascript#mocha#executable = 'yarn test'\n      let test#javascript#jest#executable = 'yarn test'\n\n      function! DebugStrategy(cmd)\n        let runner = test#determine_runner(expand('%'))\n        call luaeval(\"require('rmagatti.dap').debug\")(runner, a:cmd)\n      endfunction\n\n      function! SplitStrategy(cmd)\n        vertical new | call termopen(a:cmd)\n      endfunction\n      let g:test#custom_strategies = {'terminal_split': function('SplitStrategy'), 'debug': function('DebugStrategy')}\n      let g:test#strategy = 'terminal_split'\n\n      \" Regular mappings\n      nmap <leader>tt :TestNearest<CR>\n      nmap <leader>tf :TestFile<CR>\n      nmap <leader>ts :TestSuite<CR>\n      nmap <leader>tl :TestLast<CR>\n      nmap <leader>tv :TestVisit<CR>\n\n      \" Debug mappings\n      nmap <leader>tdt :TestNearest -strategy=debug<CR>\n      nmap <leader>tdf :TestFile -strategy=debug<CR>\n      nmap <leader>tds :TestSuite -strategy=debug<CR>\n      nmap <leader>tdl :TestLast -strategy=debug<CR>\n      nmap <leader>tdv :TestVisit -strategy=debug<CR>\n    \bcmd\bvim\0" },
    keys = { { "n", "<leader>tf" }, { "n", "<leader>tt" }, { "n", "<leader>ts" }, { "n", "<leader>tf" }, { "n", "<leader>tt" }, { "n", "<leader>tf" }, { "n", "<leader>ts" }, { "n", "<leader>tl" }, { "n", "<leader>tv" }, { "n", "<leader>tdt" }, { "n", "<leader>tdf" }, { "n", "<leader>tds" }, { "n", "<leader>tdl" }, { "n", "<leader>tdv" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-test",
    url = "https://github.com/vim-test/vim-test"
  },
  ["vim-visual-multi"] = {
    keys = { { "", "<C-n>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  vimpeccable = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vimpeccable",
    url = "https://github.com/svermeulen/vimpeccable"
  },
  vimwiki = {
    keys = { { "n", "<leader>ww" }, { "n", "<leader>wi" }, { "n", "<leader>w<leader>w" }, { "n", "<leader>ws" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vimwiki",
    url = "https://github.com/vimwiki/vimwiki"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23rmagatti.which-key\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    config = { "\27LJ\2\nÓ\1\0\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0h        nnoremap <leader>zz :lua require(\"zen-mode\").toggle({ window = { width = .40 }})<CR>\n      \bcmd\bvim\fplugins\1\0\0\nkitty\1\0\0\1\0\2\fenabled\2\tfont\a+4\nsetup\rzen-mode\frequire\0" },
    keys = { { "", "<leader>zz" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^lightspeed"] = "lightspeed.nvim",
  ["^lsp_signature"] = "lsp_signature.nvim",
  ["^lspconfig"] = "nvim-lspconfig",
  ["^lspkind"] = "lspkind-nvim",
  ["^lua%-dev"] = "lua-dev.nvim",
  ["^nvim%-web%-devicons"] = "nvim-web-devicons",
  ["^sniprun"] = "sniprun",
  ["^telescope"] = "telescope.nvim",
  ["^telescope%._extensions%.dap"] = "telescope-dap.nvim",
  ["^vimp"] = "vimpeccable"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: indent-blankline.nvim
time([[Setup for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nê\1\0\0\2\0\6\0\t6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0K\0\1\0\1\2\0\0\15toggleterm&indent_blankline_filetype_exclude\1\2\0\0\rterminal%indent_blankline_buftype_exclude\6g\bvim\0", "setup", "indent-blankline.nvim")
time([[Setup for indent-blankline.nvim]], false)
-- Setup for: vimwiki
time([[Setup for vimwiki]], true)
try_loadstring("\27LJ\2\ní\2\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0>        let g:vimwiki_listsyms = '‚úó‚óã‚óê‚óè‚úì'\n      ®\1let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md', 'nested_syntaxes':{'python': 'python', 'c++': 'cpp', 'typescript': 'typescript'}}]\bcmd\bvim\0", "setup", "vimwiki")
time([[Setup for vimwiki]], false)
-- Config for: firenvim
time([[Config for firenvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22rmagatti.firenvim\frequire\0", "config", "firenvim")
time([[Config for firenvim]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rmagatti.tokyonight\frequire\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: vim-dirvish-dovish
time([[Config for vim-dirvish-dovish]], true)
try_loadstring("\27LJ\2\nπ\a\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0ô\a        let g:dirvish_dovish_map_keys = 0\n\n        augroup dirvish_config\n        autocmd!\n        \" unmap dirvish default\n        autocmd FileType dirvish silent! unmap <buffer><C-p>\n        autocmd FileType dirvish silent! unmap <buffer>p\n\n        \" My mappings\n        autocmd FileType dirvish silent! map <buffer>i <Plug>(dovish_create_file)\n        autocmd FileType dirvish silent! map <buffer>I <Plug>(dovish_create_directory)\n        autocmd FileType dirvish silent! map <buffer>dd <Plug>(dovish_delete)\n        autocmd FileType dirvish silent! map <buffer>r <Plug>(dovish_rename)\n        autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)\n        autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)\n        autocmd FileType dirvish silent! map <buffer>p <Plug>(dovish_copy)\n        autocmd FileType dirvish silent! map <buffer>P <Plug>(dovish_move)\n        augroup END\n      \bcmd\bvim\0", "config", "vim-dirvish-dovish")
time([[Config for vim-dirvish-dovish]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21rmagatti.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23rmagatti.which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: vim-dirvish
time([[Config for vim-dirvish]], true)
try_loadstring("\27LJ\2\n≥\2\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0ì\2      command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish\n      command! VLeftDirvishFile leftabove vsplit | vertical resize 50 | silent Dirvish %\n      nnoremap <leader>fs :VLeftDirvish<CR>\n      nnoremap <leader>ff :VLeftDirvishFile<CR>\n      \bcmd\bvim\0", "config", "vim-dirvish")
time([[Config for vim-dirvish]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rmagatti.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-lsp-installer
time([[Config for nvim-lsp-installer]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17rmagatti.lsp\frequire\0", "config", "nvim-lsp-installer")
time([[Config for nvim-lsp-installer]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26rmagatti.auto-session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: igs.nvim
time([[Config for igs.nvim]], true)
try_loadstring("\27LJ\2\nJ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\21default_mappings\2\nsetup\bigs\frequire\0", "config", "igs.nvim")
time([[Config for igs.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SnipRun lua require("packer.load")({'sniprun'}, { cmd = "SnipRun", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gstatus lua require("packer.load")({'vim-fugitive'}, { cmd = "Gstatus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gblame lua require("packer.load")({'vim-fugitive'}, { cmd = "Gblame", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gpush lua require("packer.load")({'vim-fugitive'}, { cmd = "Gpush", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TodoTelescope lua require("packer.load")({'todo-comments.nvim'}, { cmd = "TodoTelescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gvdiffsplit lua require("packer.load")({'vim-fugitive'}, { cmd = "Gvdiffsplit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspTrouble lua require("packer.load")({'lsp-trouble.nvim'}, { cmd = "LspTrouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TodoQuickFix lua require("packer.load")({'todo-comments.nvim'}, { cmd = "TodoQuickFix", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Grepper lua require("packer.load")({'vim-grepper'}, { cmd = "Grepper", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[au CmdUndefined <Plug>(GrepperOperator) ++once lua require"packer.load"({'vim-grepper'}, {}, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Rg lua require("packer.load")({'vim-ripgrep'}, { cmd = "Rg", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file EasyAlign lua require("packer.load")({'vim-easy-align'}, { cmd = "EasyAlign", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Cheat lua require("packer.load")({'cheat.sh-vim'}, { cmd = "Cheat", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file CheatPaste lua require("packer.load")({'cheat.sh-vim'}, { cmd = "CheatPaste", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ToggleTermCloseAll lua require("packer.load")({'nvim-toggleterm.lua'}, { cmd = "ToggleTermCloseAll", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file JsDoc lua require("packer.load")({'vim-jsdoc'}, { cmd = "JsDoc", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ToggleTerm lua require("packer.load")({'nvim-toggleterm.lua'}, { cmd = "ToggleTerm", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ToggleTermOpenAll lua require("packer.load")({'nvim-toggleterm.lua'}, { cmd = "ToggleTermOpenAll", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutlineOpen lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutlineOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutlineClose lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutlineClose", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gpull lua require("packer.load")({'vim-fugitive'}, { cmd = "Gpull", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Bufferize lua require("packer.load")({'bufferize.vim'}, { cmd = "Bufferize", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TodoTrouble lua require("packer.load")({'todo-comments.nvim'}, { cmd = "TodoTrouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[nnoremap <silent> <leader>tdv <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tdv", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tt <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>xx <cmd>lua require("packer.load")({'lsp-trouble.nvim'}, { keys = "<lt>leader>xx", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> F <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ds <cmd>lua require("packer.load")({'vim-surround'}, { keys = "ds", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>ddo <cmd>lua require("packer.load")({'diffview.nvim'}, { keys = "<lt>leader>ddo", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> cs <cmd>lua require("packer.load")({'vim-surround'}, { keys = "cs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>ss <cmd>lua require("packer.load")({'session-lens'}, { keys = "<lt>leader>ss", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>u <cmd>lua require("packer.load")({'undotree'}, { keys = "<lt>leader>u", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>gb <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>gb", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>3s <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>leader>3s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>KK <cmd>lua require("packer.load")({'cheat.sh-vim'}, { keys = "<lt>leader>KK", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tdl <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tdl", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>gd <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>gd", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>3v <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>leader>3v", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> gpd <cmd>lua require("packer.load")({'goto-preview'}, { keys = "gpd", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>db <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>leader>db", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>ts <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>ts", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>hp <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>hp", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> cx <cmd>lua require("packer.load")({'vim-exchange'}, { keys = "cx", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>2s <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>leader>2s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> gpr <cmd>lua require("packer.load")({'goto-preview'}, { keys = "gpr", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[xnoremap <silent> X <cmd>lua require("packer.load")({'vim-exchange'}, { keys = "X", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>pg <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>pg", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>hr <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>hr", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>ww <cmd>lua require("packer.load")({'vimwiki'}, { keys = "<lt>leader>ww", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>hR <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>hR", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> f <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <M-CR> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>M-CR>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>y <cmd>lua require("packer.load")({'nvim-neoclip.lua'}, { keys = "<lt>leader>y", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> gpi <cmd>lua require("packer.load")({'goto-preview'}, { keys = "gpi", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ys <cmd>lua require("packer.load")({'vim-surround'}, { keys = "ys", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>ws <cmd>lua require("packer.load")({'vimwiki'}, { keys = "<lt>leader>ws", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tdt <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tdt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tv <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tv", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> S <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "S", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>wi <cmd>lua require("packer.load")({'vimwiki'}, { keys = "<lt>leader>wi", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tt <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-\> <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>C-\\>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> gc <cmd>lua require("packer.load")({'vim-commentary'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>b <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>b", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>w<leader>w <cmd>lua require("packer.load")({'vimwiki'}, { keys = "<lt>leader>w<lt>leader>w", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>ts <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>ts", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> s <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[inoremap <silent> <C-\> <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>C-\\>" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-n> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>C-n>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> <leader>re <cmd>lua require("packer.load")({'refactoring.nvim'}, { keys = "<lt>leader>re", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-p> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-p>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tds <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tds", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tdf <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tdf", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tl <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tl", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>hb <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>hb", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>2v <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>leader>2v", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>hu <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>hu", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>zz <cmd>lua require("packer.load")({'zen-mode.nvim'}, { keys = "<lt>leader>zz", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>KB <cmd>lua require("packer.load")({'cheat.sh-vim'}, { keys = "<lt>leader>KB", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>ps <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>ps", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tf <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tf", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[xnoremap <silent> S <cmd>lua require("packer.load")({'vim-surround'}, { keys = "S", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> gs <cmd>lua require("packer.load")({'vim-grepper'}, { keys = "gs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[xnoremap <silent> gs <cmd>lua require("packer.load")({'vim-grepper'}, { keys = "gs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> gP <cmd>lua require("packer.load")({'goto-preview'}, { keys = "gP", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>hp <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>hp", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>hs <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>hs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>gg <cmd>lua require("packer.load")({'neogit'}, { keys = "<lt>leader>gg", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>dB <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>leader>dB", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tf <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tf", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tf <cmd>lua require("packer.load")({'vim-test'}, { keys = "<lt>leader>tf", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>4s <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>leader>4s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>pl <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>pl", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>4v <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>leader>4v", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>KP <cmd>lua require("packer.load")({'cheat.sh-vim'}, { keys = "<lt>leader>KP", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vimwiki'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'vim-jsdoc'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'lua-dev.nvim'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { ft = "qf" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript.jsx ++once lua require("packer.load")({'vim-jsdoc'}, { ft = "javascript.jsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType terraform ++once lua require("packer.load")({'vim-terraform'}, { ft = "terraform" }, _G.packer_plugins)]]
vim.cmd [[au FileType vimwiki ++once lua require("packer.load")({'vimwiki'}, { ft = "vimwiki" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-jsdoc'}, { ft = "javascript" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'nvim-lightbulb', 'nvim-treesitter-textsubjects', 'targets.vim', 'fzf', 'nvim-ts-rainbow', 'nvim-ts-context-commentstring', 'nvim-treesitter-textobjects', 'alternate-toggler'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'friendly-snippets', 'vim-vsnip'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'copilot.vim', 'nvim-autopairs', 'indent-blankline.nvim', 'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'gitsigns.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-terraform/ftdetect/hcl.vim]], true)
vim.cmd [[source /Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-terraform/ftdetect/hcl.vim]]
time([[Sourcing ftdetect script at: /Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-terraform/ftdetect/hcl.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
