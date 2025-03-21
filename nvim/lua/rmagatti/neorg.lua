local M = {}

M.setup = function()
  require("neorg").setup {
    load = {
      -- ["core.completion"] = {
      --   config = {
      --     engine = "nvim-cmp",
      --   },
      -- },
      ["core.completion"] = {
        config = { engine = { module_name = "external.lsp-completion" } },
      },
      ["external.interim-ls"] = {
        config = {
          -- default config shown
          completion_provider = {
            -- Enable or disable the completion provider
            enable = true,

            -- Show file contents as documentation when you complete a file name
            documentation = true,

            -- Try to complete categories provided by Neorg Query. Requires `benlubas/neorg-query`
            categories = false,
          }
        }
      },
      ["core.integrations.telescope"] = {},
      ["core.defaults"] = {},  -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.keybinds"] = {
        config = {
          hook = function(keybinds)
            -- Want to move one keybind into the other? `remap_key` moves the data of the
            -- first keybind to the second keybind, then unbinds the first keybind.
            keybinds.remap_key("norg", "n", "<C-Space>", "<localleader><localleader>")
          end,
        },
      },
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/.notes",
          },
          default_workspace = "notes",
          index = "index.norg",
        },
      },
    },
  }

  vim.keymap.set("n", "<leader>nn", ":Neorg index<CR>", { silent = true, noremap = true })
  vim.keymap.set("n", "<leader>nr", ":Neorg return<CR>", { silent = true, noremap = true })

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.norg",
    callback = function()
      vim.opt_local.conceallevel = 2
    end,
  })
end

return M
