-- opencode.nvim configuration
-- Documentation: https://github.com/NickvanDyke/opencode.nvim

local M = {}

M.setup = function()
  ---@type opencode.Opts
  vim.g.opencode_opts = {
    -- Auto-reload buffers when opencode edits them
    auto_reload = true,
    -- Use snacks for input and picker (you already have snacks.nvim)
    provider = {
      enabled = "snacks",
    },
  }

  -- Required for auto_reload
  vim.o.autoread = true

  -- Keymaps - using <leader>o prefix to avoid conflicts
  vim.keymap.set({ "n", "x" }, "<leader>oa", function()
    require("opencode").ask("@this: ", { submit = true })
  end, { desc = "Ask opencode" })

  vim.keymap.set({ "n", "x" }, "<leader>ox", function()
    require("opencode").select()
  end, { desc = "Execute opencode action…" })

  vim.keymap.set({ "n", "x" }, "<leader>op", function()
    require("opencode").prompt("@this")
  end, { desc = "Add to opencode (prompt)" })

  -- Only in normal mode - removed 't' to avoid space delay in terminal insert mode
  vim.keymap.set("n", "<leader>oo", function()
    require("opencode").toggle()
  end, { desc = "Toggle opencode" })

  vim.keymap.set("n", "<leader>ou", function()
    require("opencode").command("session.half.page.up")
  end, { desc = "opencode scroll up" })

  vim.keymap.set("n", "<leader>od", function()
    require("opencode").command("session.half.page.down")
  end, { desc = "opencode scroll down" })
end

return M
