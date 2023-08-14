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

require("lazy").setup({
  {
    "tpope/vim-commentary",
    keys = {
      { "gc" },
      { "gc", mode = "v" },
    }
  },
  { "tpope/vim-abolish" },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "tpope/vim-surround",
    keys = {
      { "cs" },
      { "ds" },
      { "S", mode = "x" },
      { "ys" },
    },
  },
  {
    "tpope/vim-repeat",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require "rmagatti.toggleterm"
    end,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.cmd [[nnoremap <leader>u :UndotreeShow<CR>]]
    end,
    keys = "<leader>u",
  },
  {
    "jremmen/vim-ripgrep",
    cmd = { "Rg" },
  },
  -- {
  --   "mhinz/vim-grepper",
  --   lazy = false,
  --   config = function()
  --     vim.cmd [[
  --       nmap gs <Plug>(GrepperOperator)
  --       xmap gs <Plug>(GrepperOperator)
  --     ]]
  --   end,
  --   cmd = { "Grepper", "<Plug>(GrepperOperator)" },
  --   keys = {
  --     { "gs" },
  --   },
  -- },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require "rmagatti.nvim-web-devicons"
    end,
  },
  {
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
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require "rmagatti.nvim-autopairs"
    end,
    event = "InsertEnter",
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("rmagatti.oil").setup()
    end,
  },
  {
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
  },
  {
    "tommcdo/vim-exchange",
    keys = {
      { "cx" },
      { "X", mode = "x" },
    },
  },
  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      require "rmagatti.firenvim"
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    keys = "<C-n>",
    config = function()
      vim.cmd [[let g:VM_custom_motions  = {'h': 'j', 'j': 'k', 'k':'l', 'l':';'}]]
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "j-hui/fidget.nvim"
    },
    config = function()
      require "rmagatti.lsp"
    end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "j-hui/fidget.nvim",
    version = "legacy",
    config = function()
      require "rmagatti.fidget"
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
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
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v1.*",
    -- install jsregexp (optional!:).
    build = "make install_jsregexp",
    config = function()
      require "rmagatti.luasnip"
    end,
  },
  "rafamadriz/friendly-snippets",
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp", },
  { "hrsh7th/cmp-buffer", },
  { "hrsh7th/cmp-path", },
  { "hrsh7th/cmp-cmdline", },
  { "lukas-reineke/cmp-rg", },
  {
    "David-Kunz/cmp-npm",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp"
    },
    config = function()
      require("cmp-npm").setup {}
    end,
  },
  {
    "onsails/lspkind-nvim",
  },
  {
    "folke/neodev.nvim"
  },
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function()
      require "rmagatti.telescope"
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      require("rmagatti.fugitive").setup()
    end,
    keys = {
      { "<leader>gb" },
      { "<leader>gd" },
    }
  },
  {
    "tpope/vim-rhubarb",
    dependencies = "vim-fugitive",
  },
  {
    "TimUntersberger/neogit",
    optional = true,
    cmd = { "Neogit" },
    keys = {
      { "<leader>gg" },
    },
    config = function()
      require("neogit").setup {
        integrations = {
          diffview = true,
        },
      }
      vim.cmd [[nnoremap <leader>gg <cmd>Neogit<CR>]]
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require "rmagatti.diffview"
    end,
    cmd = { "DiffviewOpen" },
    keys = "<leader>ddo",
  },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
      require "rmagatti.tokyonight"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter", -- TODO: lazy load me! (maybe)
    build = ":TSUpdate",
    config = function()
      require "rmagatti.treesitter"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter-context",
  },
  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "TSPlaygroundToggle",
  },
  {
    "p00f/nvim-ts-rainbow",
    event = "BufReadPost",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost" },
  },
  {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost" },
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "rmagatti.gitsigns"
    end,
    event = "BufRead",
  },
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
    event = { "BufReadPost" },
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "kevinhwang91/nvim-bqf", "junegunn/fzf" },
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { { "nvim-tree/nvim-web-devicons", optional = true } },
    config = function()
      require "rmagatti.lualine"
    end,
  },
  {
    "hashivim/vim-terraform",
    ft = { "terraform" },
  },
  {
    "wellle/targets.vim",
    event = { "BufReadPost" },
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup {
        highlight_hovered_item = true,
        show_guides = true,
      }
    end,
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('rmagatti.nvim-lint').setup()
    end
  },
  {
    "heavenshell/vim-jsdoc",
    ft = { "javascript", "javascript.jsx", "typescript" },
    cmd = "JsDoc",
    build = "make install",
  },
  {
    "kevinhwang91/nvim-bqf",
    dependencies = { { "junegunn/fzf", optional = true }, { "junegunn/fzf.vim", optional = true } },
    ft = { "qf" },
    -- config = function()
    --   require("bqf").setup {
    --     auto_enable = true,
    --   }
    -- end,
  },
  {
    "junegunn/vim-easy-align",
    config = function()
      require "rmagatti.easyalign"
    end,
    cmd = { "EasyAlign" },
  },
  -- DAP
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("telescope").load_extension "dap"
      require "rmagatti.dap"
    end,
    keys = { { "<leader>db" }, { "<leader>dB" } },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = "mfussenegger/nvim-dap",
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "dap"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require "rmagatti.dap.dap-ui"
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require "rmagatti.which-key"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "InsertEnter" },
    init = function()
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_filetype_exclude = { "toggleterm" }
    end,
  },
  {
    "AndrewRadev/bufferize.vim",
    cmd = { "Bufferize" },
  },
  {
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
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "tami5/sqlite.lua", },
    config = function()
      require("neoclip").setup {
        enable_persistant_history = true,
      }
      vim.cmd [[nnoremap <leader>y <cmd>lua require('telescope').extensions.neoclip.default()<CR>]]
    end,
    keys = {
      { "<leader>y" },
    },
  },
  {
    "rmagatti/auto-session",
    config = function()
      require "rmagatti.auto-session"
    end,
    dev = true
  },
  {
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
  },
  {
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
  },
  {
    "rmagatti/igs.nvim",
    event = { "BufReadPost" },
    config = function()
      require "rmagatti.igs"
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("rmagatti.copilot").setup()
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("rmagatti.copilot-cmp").setup()
    end,
  },
  {
    "eandrju/cellular-automaton.nvim",
    config = function()
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { noremap = true })
    end,
    keys = {
      { "<leader>fml" },
    },
  },
  {
    "sourcegraph/sg.nvim",
    config = require("rmagatti.sg").setup,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/cmp-nvim-lsp"
    },
  },
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy"
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("rmagatti.dressing").setup()
    end,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = function()
      require("rmagatti.neorg").setup()
    end,
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
  },
  {
    "rmagatti/gx-extended.nvim",
    config = function()
      require("rmagatti.gx-extended").setup()
    end,
    dev = true
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("rmagatti.refactoring").setup()
    end,
  }
}, { defaults = { lazy = true }, dev = { path = "~/Projects" } })
