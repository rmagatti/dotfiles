local M = {}

M.custom_buffers = function()
  local Snacks = require("snacks")
  
  Snacks.picker.buffers({
    confirm = function(picker, item)
      -- Default confirm behavior
      if item then
        vim.api.nvim_set_current_buf(item.buf)
      end
      picker:close()
    end,
    actions = {
      ["<c-d>"] = function(picker, item)
        if item and item.buf then
          vim.cmd("bd" .. item.buf)
          picker:refresh()
        end
      end
    }
  })
end

M.setup = function()
  vim.keymap.set("n", "<leader>b", M.custom_buffers, { desc = "Buffer picker with delete" })
end

return M
