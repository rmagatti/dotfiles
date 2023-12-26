---@diagnostic disable: missing-fields
require("bqf").setup {
  preview = {
    should_preview_cb = function(bufnr, qwinid)
      local ret = true
      local bufname = vim.api.nvim_buf_get_name(bufnr)

      if bufname:match('^fugitive://') then
        -- skip fugitive buffer
        ret = false
      end
      return ret
    end
  }
}
