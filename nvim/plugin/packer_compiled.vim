" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
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

time("Luarocks path setup", true)
local package_path_str = "/Users/ronnieandrewmagatti/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/ronnieandrewmagatti/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/ronnieandrewmagatti/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/ronnieandrewmagatti/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/ronnieandrewmagatti/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["alternate-toggler"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/alternate-toggler"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26rmagatti.auto-session\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/auto-session"
  },
  ["bufferize.vim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/bufferize.vim"
  },
  ["cheat.sh-vim"] = {
    commands = { "Cheat", "CheatPaste" },
    keys = { { "", "n" }, { "", "<leader>KB" }, { "", "n" }, { "", "<leader>KK" }, { "", "n" }, { "", "<leader>KP" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/cheat.sh-vim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22rmagatti.diffview\frequire\0" },
    keys = { { "", "<leader>ddo" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/diffview.nvim"
  },
  firenvim = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  fzf = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf-preview.vim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/fzf-preview.vim"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["git-worktree.nvim"] = {
    config = { "\27LJ\2\n´\1\0\0\3\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\4\0009\0\5\0'\2\6\0B\0\2\1K\0\1\0Fnnoremap <leader>wt <cmd>Telescope git_worktree git_worktrees<CR>\bcmd\bvim\17git_worktree\19load_extension\14telescope\frequire\0" },
    keys = { { "", "<leader>wt" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/git-worktree.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22rmagatti.gitsigns\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    commands = { "Goyo" },
    config = { "\27LJ\2\n`\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0A      let g:goyo_width=120\n      let g:goyo_height=90\n      \bcmd\bvim\0" },
    keys = { { "", "<leader>zz" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/goyo.vim"
  },
  ["limelight.vim"] = {
    commands = { "Limelight" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/limelight.vim"
  },
  ["lsp-trouble.nvim"] = {
    commands = { "LspTrouble" },
    config = { "\27LJ\2\nu\0\0\3\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\2\5\0B\0\2\1K\0\1\0,nnoremap <leader>xx <cmd>LspTrouble<CR>\bcmd\bvim\nsetup\ftrouble\frequire\0" },
    keys = { { "", "<leader>xx" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/lsp-trouble.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\n \1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14decorator\1\3\0\0\6`\6`\17handler_opts\1\0\1\vborder\vshadow\1\0\5\tbind\2\16hint_scheme\vString\16hint_prefix\nüêº \16hint_enable\2\14doc_lines\3\n\14on_attach\18lsp_signature\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21rmagatti.lualine\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vneogit\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28rmagatti.nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-bqf"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rmagatti.nvim-compe\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\na\0\0\3\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\1K\0\1\0\17rmagatti.dap\bdap\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-lightbulb"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28rmagatti.nvim-lightbulb\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lsp-ts-utils"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31rmagatti.nvim-lsp-ts-utils\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    after = { "nvim-lsp-ts-utils" },
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 rmagatti.lsp-server-configs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-lspinstall"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-textobjects" },
    only_config = true
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {},
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31rmagatti.nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/quick-scope"
  },
  ["session-lens"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26rmagatti.session-lens\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/session-lens"
  },
  ["symbols-outline.nvim"] = {
    config = { "\27LJ\2\ni\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\16show_guides\2\27highlight_hovered_item\2\nsetup\20symbols-outline\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope-lsp-handlers.nvim"] = {
    config = { "\27LJ\2\nQ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\17lsp_handlers\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/telescope-lsp-handlers.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23rmagatti.telescope\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rmagatti.tokyonight\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  undotree = {
    config = { "\27LJ\2\nH\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0)nnoremap <leader>u :UndotreeShow<CR>\bcmd\bvim\0" },
    keys = { { "", "<leader>u" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dirvish"] = {
    config = { "\27LJ\2\n≥\2\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0ì\2      command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish\n      command! VLeftDirvishFile leftabove vsplit | vertical resize 50 | silent Dirvish %\n      nnoremap <leader>fs :VLeftDirvish<CR>\n      nnoremap <leader>ff :VLeftDirvishFile<CR>\n      \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dirvish-dovish"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-dirvish-dovish"
  },
  ["vim-dirvish-git"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-dirvish-git"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23rmagatti.easyalign\frequire\0" },
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-exchange"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-exchange"
  },
  ["vim-fugitive"] = {
    commands = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gvdiffsplit" },
    config = { "\27LJ\2\n‘\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0¥\1      nnoremap <silent> <leader>gb :<C-u>Git blame<CR>\n      nnoremap <leader>gd :Gvdiffsplit!<CR>\n      nnoremap gj :diffget //2<CR>\n      nnoremap g; :diffget //3<CR>\n      \bcmd\bvim\0" },
    keys = { { "", "n" }, { "", "<leader>gd" }, { "", "n" }, { "", "<leader>gb" }, { "", "n" }, { "", "<leader>hp" } },
    loaded = false,
    needs_bufread = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  },
  ["vim-graphql"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-graphql"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-indent-object"
  },
  ["vim-jsdoc"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-jsdoc"
  },
  ["vim-ripgrep"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-ripgrep"
  },
  ["vim-sneak"] = {
    keys = { { "", "n" }, { "", "s" }, { "", "n" }, { "", "S" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-sneak"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    config = { "vim.g.startuptime_tries = 10" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/opt/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  },
  ["yats.vim"] = {
    loaded = true,
    path = "/Users/ronnieandrewmagatti/.local/share/nvim/site/pack/packer/start/yats.vim"
  }
}

time("Defining packer_plugins", false)
-- Config for: telescope.nvim
time("Config for telescope.nvim", true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23rmagatti.telescope\frequire\0", "config", "telescope.nvim")
time("Config for telescope.nvim", false)
-- Config for: nvim-compe
time("Config for nvim-compe", true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rmagatti.nvim-compe\frequire\0", "config", "nvim-compe")
time("Config for nvim-compe", false)
-- Config for: nvim-autopairs
time("Config for nvim-autopairs", true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28rmagatti.nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time("Config for nvim-autopairs", false)
-- Config for: tokyonight.nvim
time("Config for tokyonight.nvim", true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rmagatti.tokyonight\frequire\0", "config", "tokyonight.nvim")
time("Config for tokyonight.nvim", false)
-- Config for: telescope-fzf-native.nvim
time("Config for telescope-fzf-native.nvim", true)
try_loadstring("\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0", "config", "telescope-fzf-native.nvim")
time("Config for telescope-fzf-native.nvim", false)
-- Config for: symbols-outline.nvim
time("Config for symbols-outline.nvim", true)
try_loadstring("\27LJ\2\ni\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\16show_guides\2\27highlight_hovered_item\2\nsetup\20symbols-outline\frequire\0", "config", "symbols-outline.nvim")
time("Config for symbols-outline.nvim", false)
-- Config for: lsp_signature.nvim
time("Config for lsp_signature.nvim", true)
try_loadstring("\27LJ\2\n \1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14decorator\1\3\0\0\6`\6`\17handler_opts\1\0\1\vborder\vshadow\1\0\5\tbind\2\16hint_scheme\vString\16hint_prefix\nüêº \16hint_enable\2\14doc_lines\3\n\14on_attach\18lsp_signature\frequire\0", "config", "lsp_signature.nvim")
time("Config for lsp_signature.nvim", false)
-- Config for: todo-comments.nvim
time("Config for todo-comments.nvim", true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time("Config for todo-comments.nvim", false)
-- Config for: nvim-web-devicons
time("Config for nvim-web-devicons", true)
try_loadstring("\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31rmagatti.nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time("Config for nvim-web-devicons", false)
-- Config for: gitsigns.nvim
time("Config for gitsigns.nvim", true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22rmagatti.gitsigns\frequire\0", "config", "gitsigns.nvim")
time("Config for gitsigns.nvim", false)
-- Config for: telescope-lsp-handlers.nvim
time("Config for telescope-lsp-handlers.nvim", true)
try_loadstring("\27LJ\2\nQ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\17lsp_handlers\19load_extension\14telescope\frequire\0", "config", "telescope-lsp-handlers.nvim")
time("Config for telescope-lsp-handlers.nvim", false)
-- Config for: session-lens
time("Config for session-lens", true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26rmagatti.session-lens\frequire\0", "config", "session-lens")
time("Config for session-lens", false)
-- Config for: vim-dirvish
time("Config for vim-dirvish", true)
try_loadstring("\27LJ\2\n≥\2\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0ì\2      command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish\n      command! VLeftDirvishFile leftabove vsplit | vertical resize 50 | silent Dirvish %\n      nnoremap <leader>fs :VLeftDirvish<CR>\n      nnoremap <leader>ff :VLeftDirvishFile<CR>\n      \bcmd\bvim\0", "config", "vim-dirvish")
time("Config for vim-dirvish", false)
-- Config for: lualine.nvim
time("Config for lualine.nvim", true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21rmagatti.lualine\frequire\0", "config", "lualine.nvim")
time("Config for lualine.nvim", false)
-- Config for: vim-easy-align
time("Config for vim-easy-align", true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23rmagatti.easyalign\frequire\0", "config", "vim-easy-align")
time("Config for vim-easy-align", false)
-- Config for: nvim-dap
time("Config for nvim-dap", true)
try_loadstring("\27LJ\2\na\0\0\3\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\1K\0\1\0\17rmagatti.dap\bdap\19load_extension\14telescope\frequire\0", "config", "nvim-dap")
time("Config for nvim-dap", false)
-- Config for: nvim-treesitter
time("Config for nvim-treesitter", true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rmagatti.treesitter\frequire\0", "config", "nvim-treesitter")
time("Config for nvim-treesitter", false)
-- Config for: auto-session
time("Config for auto-session", true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26rmagatti.auto-session\frequire\0", "config", "auto-session")
time("Config for auto-session", false)
-- Config for: nvim-lightbulb
time("Config for nvim-lightbulb", true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28rmagatti.nvim-lightbulb\frequire\0", "config", "nvim-lightbulb")
time("Config for nvim-lightbulb", false)
-- Load plugins in order defined by `after`
time("Sequenced loading", true)
vim.cmd [[ packadd nvim-treesitter-textobjects ]]
vim.cmd [[ packadd nvim-lspinstall ]]

-- Config for: nvim-lspinstall
try_loadstring("\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 rmagatti.lsp-server-configs\frequire\0", "config", "nvim-lspinstall")

vim.cmd [[ packadd nvim-lsp-ts-utils ]]

-- Config for: nvim-lsp-ts-utils
try_loadstring("\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31rmagatti.nvim-lsp-ts-utils\frequire\0", "config", "nvim-lsp-ts-utils")

time("Sequenced loading", false)

-- Command lazy-loads
time("Defining lazy-load commands", true)
vim.cmd [[command! -nargs=* -range -bang -complete=file CheatPaste lua require("packer.load")({'cheat.sh-vim'}, { cmd = "CheatPaste", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file LspTrouble lua require("packer.load")({'lsp-trouble.nvim'}, { cmd = "LspTrouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Gvdiffsplit lua require("packer.load")({'vim-fugitive'}, { cmd = "Gvdiffsplit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Goyo lua require("packer.load")({'goyo.vim'}, { cmd = "Goyo", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Gblame lua require("packer.load")({'vim-fugitive'}, { cmd = "Gblame", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Gpush lua require("packer.load")({'vim-fugitive'}, { cmd = "Gpush", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Gpull lua require("packer.load")({'vim-fugitive'}, { cmd = "Gpull", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Limelight lua require("packer.load")({'limelight.vim'}, { cmd = "Limelight", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Cheat lua require("packer.load")({'cheat.sh-vim'}, { cmd = "Cheat", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Gstatus lua require("packer.load")({'vim-fugitive'}, { cmd = "Gstatus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time("Defining lazy-load commands", false)

-- Keymap lazy-loads
time("Defining lazy-load keymaps", true)
vim.cmd [[noremap <silent> <leader>gd <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>gd", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> n <cmd>lua require("packer.load")({'vim-sneak'}, { keys = "n", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> n <cmd>lua require("packer.load")({'cheat.sh-vim'}, { keys = "n", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> n <cmd>lua require("packer.load")({'vim-sneak'}, { keys = "n", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> n <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "n", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>u <cmd>lua require("packer.load")({'undotree'}, { keys = "<lt>leader>u", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>hp <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>hp", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> n <cmd>lua require("packer.load")({'cheat.sh-vim'}, { keys = "n", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>KP <cmd>lua require("packer.load")({'cheat.sh-vim'}, { keys = "<lt>leader>KP", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>wt <cmd>lua require("packer.load")({'git-worktree.nvim'}, { keys = "<lt>leader>wt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>KK <cmd>lua require("packer.load")({'cheat.sh-vim'}, { keys = "<lt>leader>KK", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>ddo <cmd>lua require("packer.load")({'diffview.nvim'}, { keys = "<lt>leader>ddo", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> n <cmd>lua require("packer.load")({'cheat.sh-vim'}, { keys = "n", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> S <cmd>lua require("packer.load")({'vim-sneak'}, { keys = "S", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>KB <cmd>lua require("packer.load")({'cheat.sh-vim'}, { keys = "<lt>leader>KB", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>xx <cmd>lua require("packer.load")({'lsp-trouble.nvim'}, { keys = "<lt>leader>xx", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>zz <cmd>lua require("packer.load")({'goyo.vim'}, { keys = "<lt>leader>zz", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> n <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "n", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> n <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "n", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> s <cmd>lua require("packer.load")({'vim-sneak'}, { keys = "s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>gb <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>gb", prefix = "" }, _G.packer_plugins)<cr>]]
time("Defining lazy-load keymaps", false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time("Defining lazy-load filetype autocommands", true)
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-jsdoc'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript.jsx ++once lua require("packer.load")({'vim-jsdoc'}, { ft = "javascript.jsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'vim-jsdoc'}, { ft = "typescript" }, _G.packer_plugins)]]
time("Defining lazy-load filetype autocommands", false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
