local M = {}

M.setup = function()
  require("neorg").setup {
    load = {
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.integrations.telescope"] = {},
      ["core.defaults"] = {}, -- Loads default behaviour
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
            origami = "~/.notes/origami_notes",
          },
          default_workspace = "notes",
          index = "index.norg",
        },
      },
    },
  }

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.norg",
    callback = function()
      vim.opt_local.conceallevel = 2
    end,
  })
end

return M
