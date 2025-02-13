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
  { "tpope/vim-eunuch" },
  {
    "tpope/vim-commentary",
    keys = {
      { "gc" },
      { "gc", mode = "v" },
    }
  },
  {
    "tpope/vim-abolish",
    event = "VeryLazy",
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
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
  {
    "mhinz/vim-grepper",
    lazy = false,
    init = function()
      vim.cmd [[
        nmap gs <plug>(GrepperOperator)
        xmap gs <plug>(GrepperOperator)
      ]]
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require "rmagatti.nvim-web-devicons"
    end,
  },
  -- add_if_vscode(false, {
  --   "vim-test/vim-test",
  --   config = function()
  --     require("rmagatti.vim-test").setup()
  --   end,
  --   keys = {
  --     { "<leader>tf" },
  --     { "<leader>tt" },
  --     { "<leader>ts" },
  --     { "<leader>tl" },
  --     { "<leader>tv" },
  --     { "<leader>wtf" },
  --     { "<leader>wtt" },
  --     { "<leader>wts" },
  --     { "<leader>wtl" },
  --     { "<leader>wtv" },
  --     { "<leader>tdt" },
  --     { "<leader>tdf" },
  --     { "<leader>tds" },
  --     { "<leader>tdl" },
  --     { "<leader>tdv" },
  --   },
  -- }),
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
      require("leap").create_default_mappings()
      vim.keymap.set({ "n", "x", "o" }, "<localleader>s", '<Plug>(leap-from-window)')
    end,
    keys = {
      { "s" },
      { "S" },
      { "f" },
      { "F" },
      { "<localleader>s", mode = { "n", "x", "o" } }
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
    lazy = false,
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
    dependencies = {
      "j-hui/fidget.nvim"
    },
    event = "BufReadPost",
    config = function()
      require "rmagatti.lsp"
    end,
  },
  { "williamboman/mason.nvim", },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require "rmagatti.fidget"
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = { "InsertEnter", "CmdlineEnter" },
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-cmdline",
  --     "lukas-reineke/cmp-rg",
  --   },
  --   config = function()
  --     require "rmagatti.nvim-cmp"
  --   end,
  -- },
  {
    "Saghen/blink.cmp",
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',
    config = function()
      require("rmagatti.blink-cmp").setup()
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
  { "rafamadriz/friendly-snippets" },
  -- { "saadparwaiz1/cmp_luasnip" },
  -- { "hrsh7th/cmp-nvim-lsp" },
  -- { "hrsh7th/cmp-buffer" },
  -- { "hrsh7th/cmp-path" },
  -- { "hrsh7th/cmp-cmdline" },
  -- { "lukas-reineke/cmp-rg" },
  -- {
  --   "David-Kunz/cmp-npm",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp"
  --   },
  --   config = function()
  --     require("cmp-npm").setup {}
  --   end,
  -- },
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
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
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
    "NeogitOrg/neogit",
    -- dev = true,
    lazy = false,
    branch = "master",
    mappings = {
      popup = {
        ["L"] = "LogPopup"
      },
      status = {
        ["k"] = "MoveDown",
        ["l"] = "MoveUp",
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
    },
    config = function()
      require("rmagatti.neogit")
    end
  },
  -- {
  --   "sindrets/diffview.nvim",
  --   config = function()
  --     require "rmagatti.diffview"
  --   end,
  --   cmd = { "DiffviewOpen" },
  --   keys = "<leader>ddo",
  -- },
  -- add_if_vscode(false, {
  --   "folke/tokyonight.nvim",
  --   lazy = false, -- make sure we load this during startup
  --   priority = 1000,
  --   config = function()
  --     require "rmagatti.tokyonight"
  --   end,
  -- }),
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000,
    config = function()
      require "rmagatti.kanagawa"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "rmagatti.treesitter"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost" },
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
    event = "VeryLazy",
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
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  -- add_if_vscode(false, {
  --   'mfussenegger/nvim-lint',
  --   event = "BufReadPost",
  --   config = function()
  --     require('rmagatti.nvim-lint').setup()
  --   end
  -- }),
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
    config = function()
      require "rmagatti.bqf"
    end,
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
    dependencies = { "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },
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
  },
  {
    "rmagatti/auto-session",
    lazy = false,
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
    dev = true,
    config = function()
      require "rmagatti.igs"
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter" },
    config = function()
      require("rmagatti.copilot").setup()
    end,
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = { "zbirenbaum/copilot.lua" },
  --   event = { "InsertEnter", "LspAttach" },
  --   config = function()
  --     require("rmagatti.copilot-cmp").setup()
  --   end,
  -- },
  {
    "eandrju/cellular-automaton.nvim",
    config = function()
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { noremap = true })
    end,
    keys = {
      { "<leader>fml" },
    },
  },
  -- {
  --   "sourcegraph/sg.nvim",
  --   config = require("rmagatti.sg").setup,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/cmp-nvim-lsp"
  --   },
  --   keys = {
  --     { "<leader>sg" },
  --   },
  -- },
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
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
    lazy = false
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = function()
      require("rmagatti.neorg").setup()
    end,
    -- build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    cmd = { "Neorg" },
    lazy = false,
    keys = {
      { "<leader>nn" }
    }
  },
  {
    "benlubas/neorg-interim-ls",
  },
  {
    "rmagatti/gx-extended.nvim",
    config = function()
      require("rmagatti.gx-extended").setup()
    end,
    keys = {
      { "gx" },
    },
    dev = true
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    lazy = true
  },
  { "cordx56/rustowl", dependencies = { "neovim/nvim-lspconfig" }, ft = 'rust' },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("rmagatti.refactoring").setup()
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre " .. vim.fn.expand "~" .. "/Documents/vault/**.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Documents/vault/**.md",
      "VeryLazy"
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "Vault",
          path = vim.fn.expand "~" .. "/Documents/vault",
        },
      },

      daily_notes = {
        folder = "Daily Notes",
        template = "Templates/Daily Note Template.md"
      }
    },

  },
  {
    "m00qek/baleia.nvim",
    config = function()
      require("baleia").setup {}
    end
  },
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-neotest/nvim-nio"
  --   },
  --   event = "VeryLazy",
  --   config = function()
  --     require("rmagatti.neotest").setup()
  --   end,
  -- }
}, { defaults = { lazy = true }, dev = { path = "~/Projects" } })
