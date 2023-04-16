local M = {}

M.setup = function()
  require("neorg").setup {
    load = {
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.integrations.telescope"] = {},
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.norg.dirman"] = { -- Manages Neorg workspaces
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

  vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "*.norg",
    callback = function ()
      vim.opt_local.conceallevel = 2
    end
  })
end

return M
