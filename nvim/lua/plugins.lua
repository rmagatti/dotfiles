local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local is_vscode = vim.g.vscode == 1

local function add_if_vscode(should_add, plugin)
  if not is_vscode then
    return plugin
  end

  if is_vscode and should_add then
    return plugin
  end
  return nil
end

require("lazy").setup({
  add_if_vscode(true, { "tpope/vim-eunuch" }),
  add_if_vscode(true, {
    "tpope/vim-commentary",
    keys = {
      { "gc" },
      { "gc", mode = "v" },
    }
  }),
  add_if_vscode(true, {
    "tpope/vim-abolish",
    event = "VeryLazy",
  }),
  add_if_vscode(true, { "JoosepAlviste/nvim-ts-context-commentstring" }),
  add_if_vscode(true, {
    "tpope/vim-surround",
    keys = {
      { "cs" },
      { "ds" },
      { "S", mode = "x" },
      { "ys" },
    },
  }),
  add_if_vscode(true, {
    "tpope/vim-repeat",
  }),
  add_if_vscode(false, {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require "rmagatti.toggleterm"
    end,
  }),
  add_if_vscode(false, {
    "mbbill/undotree",
    config = function()
      vim.cmd [[nnoremap <leader>u :UndotreeShow<CR>]]
    end,
    keys = "<leader>u",
  }),
  add_if_vscode(false, {
    "jremmen/vim-ripgrep",
    cmd = { "Rg" },
  }),
  add_if_vscode(false, {
    "mhinz/vim-grepper",
    lazy = false,
    init = function()
      vim.cmd [[
        nmap gs <plug>(GrepperOperator)
        xmap gs <plug>(GrepperOperator)
      ]]
    end,
  }),
  add_if_vscode(false, {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require "rmagatti.nvim-web-devicons"
    end,
  }),
  add_if_vscode(false, {
    "vim-test/vim-test",
    config = function()
      require("rmagatti.vim-test").setup()
    end,
    keys = {
      { "<leader>tf" },
      { "<leader>tt" },
      { "<leader>ts" },
      { "<leader>tl" },
      { "<leader>tv" },
      { "<leader>wtf" },
      { "<leader>wtt" },
      { "<leader>wts" },
      { "<leader>wtl" },
      { "<leader>wtv" },
      { "<leader>tdt" },
      { "<leader>tdf" },
      { "<leader>tds" },
      { "<leader>tdl" },
      { "<leader>tdv" },
    },
  }),
  add_if_vscode(false, {
    "windwp/nvim-autopairs",
    config = function()
      require "rmagatti.nvim-autopairs"
    end,
    event = "InsertEnter",
  }),
  add_if_vscode(false, {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("rmagatti.oil").setup()
    end,
  }),
  add_if_vscode(true, {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
    keys = {
      { "s" },
      { "S" },
      { "f" },
      { "F" },
    },
  }),
  -- add_if_vscode(true, {
  --   "tommcdo/vim-exchange",
  --   keys = {
  --     { "cx" },
  --     { "X", mode = "x" },
  --   },
  -- }),
  add_if_vscode(false, {
    "glacambre/firenvim",
    lazy = false,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      require "rmagatti.firenvim"
    end,
  }),
  add_if_vscode(false, {
    "mg979/vim-visual-multi",
    branch = "master",
    keys = "<C-n>",
    config = function()
      vim.cmd [[let g:VM_custom_motions  = {'h': 'j', 'j': 'k', 'k':'l', 'l':';'}]]
    end,
  }),
  add_if_vscode(false, {
    "neovim/nvim-lspconfig",
    dependencies = {
      "j-hui/fidget.nvim"
    },
    event = "BufReadPost",
    config = function()
      require "rmagatti.lsp"
    end,
  }),
  add_if_vscode(false, "williamboman/mason.nvim"),
  add_if_vscode(false, "williamboman/mason-lspconfig.nvim"),
  add_if_vscode(false, {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require "rmagatti.fidget"
    end,
  }),
  add_if_vscode(false, {
    "ray-x/lsp_signature.nvim",
  }),
  add_if_vscode(false, {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "lukas-reineke/cmp-rg",
    },
    config = function()
      require "rmagatti.nvim-cmp"
    end,
  }),
  add_if_vscode(false, {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v1.*",
    -- install jsregexp (optional!:).
    build = "make install_jsregexp",
    config = function()
      require "rmagatti.luasnip"
    end,
  }),
  add_if_vscode(false, "rafamadriz/friendly-snippets"),
  add_if_vscode(true, { "saadparwaiz1/cmp_luasnip" }),
  add_if_vscode(false, { "hrsh7th/cmp-nvim-lsp" }),
  add_if_vscode(false, { "hrsh7th/cmp-buffer" }),
  add_if_vscode(false, { "hrsh7th/cmp-path" }),
  add_if_vscode(false, { "hrsh7th/cmp-cmdline" }),
  add_if_vscode(false, { "lukas-reineke/cmp-rg" }),
  add_if_vscode(false, {
    "David-Kunz/cmp-npm",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp"
    },
    config = function()
      require("cmp-npm").setup {}
    end,
  }),
  add_if_vscode(false, {
    "onsails/lspkind-nvim",
  }),
  add_if_vscode(false, {
    "folke/neodev.nvim"
  }),
  add_if_vscode(false, { "nvim-lua/plenary.nvim" }),
  add_if_vscode(false, {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function()
      require "rmagatti.telescope"
    end
  }),
  add_if_vscode(false, {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    dependencies = { "nvim-telescope/telescope.nvim" },
  }),
  add_if_vscode(false, {
    "tpope/vim-fugitive",
    config = function()
      require("rmagatti.fugitive").setup()
    end,
    keys = {
      { "<leader>gb" },
      { "<leader>gd" },
    }
  }),
  add_if_vscode(false, {
    "tpope/vim-rhubarb",
    dependencies = "vim-fugitive",
  }),
  add_if_vscode(false, {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    keys = {
      { "<leader>gg" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
    },
    config = function()
      require("rmagatti.neogit")
    end
  }),
  add_if_vscode(false, {
    "sindrets/diffview.nvim",
    config = function()
      require "rmagatti.diffview"
    end,
    cmd = { "DiffviewOpen" },
    keys = "<leader>ddo",
  }),
  -- add_if_vscode(false, {
  --   "folke/tokyonight.nvim",
  --   lazy = false, -- make sure we load this during startup
  --   priority = 1000,
  --   config = function()
  --     require "rmagatti.tokyonight"
  --   end,
  -- }),
  add_if_vscode(false, {
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000,
    config = function()
      require "rmagatti.kanagawa"
    end,
  }),
  add_if_vscode(true, {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "rmagatti.treesitter"
    end,
  }),
  add_if_vscode(true, {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter-context",
  }),
  add_if_vscode(false, {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "TSPlaygroundToggle",
  }),
  add_if_vscode(true, {
    "p00f/nvim-ts-rainbow",
    event = "BufReadPost",
  }),
  add_if_vscode(false, {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost" },
  }),
  add_if_vscode(false, {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost" },
  }),
  add_if_vscode(false, {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "rmagatti.gitsigns"
    end,
    event = "BufRead",
  }),
  add_if_vscode(false, {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
    event = { "BufReadPost" },
  }),
  add_if_vscode(false, {
    "junegunn/fzf.vim",
    dependencies = { "kevinhwang91/nvim-bqf", "junegunn/fzf" },
  }),
  add_if_vscode(false, {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { { "nvim-tree/nvim-web-devicons", optional = true } },
    config = function()
      require "rmagatti.lualine"
    end,
  }),
  add_if_vscode(false, {
    "hashivim/vim-terraform",
    ft = { "terraform" },
  }),
  add_if_vscode(true, {
    "wellle/targets.vim",
    event = { "BufReadPost" },
  }),
  add_if_vscode(false, {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup {
        highlight_hovered_item = true,
        show_guides = true,
      }
    end,
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
  }),
  add_if_vscode(false, {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  }),
  -- add_if_vscode(false, {
  --   'mfussenegger/nvim-lint',
  --   event = "BufReadPost",
  --   config = function()
  --     require('rmagatti.nvim-lint').setup()
  --   end
  -- }),
  add_if_vscode(false, {
    "heavenshell/vim-jsdoc",
    ft = { "javascript", "javascript.jsx", "typescript" },
    cmd = "JsDoc",
    build = "make install",
  }),
  add_if_vscode(false, {
    "kevinhwang91/nvim-bqf",
    dependencies = { { "junegunn/fzf", optional = true }, { "junegunn/fzf.vim", optional = true } },
    ft = { "qf" },
    config = function()
      require "rmagatti.bqf"
    end,
  }),
  add_if_vscode(false, {
    "junegunn/vim-easy-align",
    config = function()
      require "rmagatti.easyalign"
    end,
    cmd = { "EasyAlign" },
  }),
  -- DAP
  add_if_vscode(false, {
    "mfussenegger/nvim-dap",
    config = function()
      require("telescope").load_extension "dap"
      require "rmagatti.dap"
    end,
    keys = { { "<leader>db" }, { "<leader>dB" } },
  }),
  add_if_vscode(false, {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = "mfussenegger/nvim-dap",
  }),
  add_if_vscode(false, {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "dap"
    end,
  }),
  add_if_vscode(false, {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require "rmagatti.dap.dap-ui"
    end,
  }),
  add_if_vscode(false, {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require "rmagatti.which-key"
    end,
  }),
  add_if_vscode(false, {
    "lukas-reineke/indent-blankline.nvim",
    event = { "InsertEnter" },
    init = function()
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_filetype_exclude = { "toggleterm" }
    end,
  }),
  add_if_vscode(false, {
    "AndrewRadev/bufferize.vim",
    cmd = { "Bufferize" },
  }),
  add_if_vscode(false, {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        plugins = {
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = true,
            font = "+4", -- font size increment
          },
        },
      }
      vim.cmd [[
        nnoremap <leader>zz :lua require("zen-mode").toggle({ window = { width = .40 }})<CR>
      ]]
    end,
    keys = "<leader>zz",
  }),
  add_if_vscode(false, {
    "AckslD/nvim-neoclip.lua",
    -- dependencies = { "tami5/sqlite.lua", },
    event = "BufReadPost",
    config = function()
      require("neoclip").setup {
        -- enable_persistant_history = true,
      }
      vim.cmd [[nnoremap <leader>y <cmd>lua require('telescope').extensions.neoclip.default()<CR>]]
    end,
    keys = {
      { "<leader>y" },
    },
  }),
  add_if_vscode(false, {
    "rmagatti/auto-session",
    config = function()
      require "rmagatti.auto-session"
    end,
    dev = true
  }),
  add_if_vscode(true, {
    "rmagatti/alternate-toggler",
    config = function()
      require("alternate-toggler").setup {
        alternates = {
          ["=="] = "!=",
        },
      }
      vim.keymap.set(
        "n",
        "<leader><space>", -- <space><space>
        require("alternate-toggler").toggleAlternate
      )
    end,
    event = { "BufReadPost" },
  }),
  add_if_vscode(false, {
    "rmagatti/goto-preview",
    dev = true,
    config = function()
      require("rmagatti.goto-preview").setup()
    end,
    keys = {
      { "gpd" },
      { "gpi" },
      { "gpr" },
      { "gP" },
      { "L" },
    },
  }),
  add_if_vscode(false, {
    "rmagatti/igs.nvim",
    event = { "BufReadPost" },
    dev = true,
    config = function()
      require "rmagatti.igs"
    end,
  }),
  add_if_vscode(false, {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter" },
    config = function()
      require("rmagatti.copilot").setup()
    end,
  }),
  add_if_vscode(false, {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    event = { "InsertEnter", "LspAttach" },
    config = function()
      require("rmagatti.copilot-cmp").setup()
    end,
  }),
  add_if_vscode(false, {
    "eandrju/cellular-automaton.nvim",
    config = function()
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { noremap = true })
    end,
    keys = {
      { "<leader>fml" },
    },
  }),
  add_if_vscode(false, {
    "sourcegraph/sg.nvim",
    config = require("rmagatti.sg").setup,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/cmp-nvim-lsp"
    },
    keys = {
      { "<leader>sg" },
    },
  }),
  add_if_vscode(false, {
    "wakatime/vim-wakatime",
    event = "VeryLazy"
  }),
  add_if_vscode(false, {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("rmagatti.dressing").setup()
    end,
  }),
  add_if_vscode(false, {
    "nvim-neorg/neorg",
    ft = "norg",
    config = function()
      require("rmagatti.neorg").setup()
    end,
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    cmd = { "Neorg" },
    keys = {
      { "<leader>nn" }
    }
  }),
  add_if_vscode(true, {
    "rmagatti/gx-extended.nvim",
    event = "VeryLazy",
    config = function()
      require("rmagatti.gx-extended").setup()
    end,
    dev = true
  }),
  add_if_vscode(false, {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("rmagatti.refactoring").setup()
    end,
  })
}, { defaults = { lazy = true }, dev = { path = "~/Projects" } })
