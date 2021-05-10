local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local delete_buffer = function(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  vim.cmd("bd"..selection.bufnr)
  actions.close(prompt_bufnr)
end

local on_attach_mappings = function(_, map)
  map('i', '<c-d>', delete_buffer)
  return true
end

local M = {}
M.custom_buffers = function()
  require'telescope.builtin'.buffers {
    show_all_buffers=true,
    attach_mappings = on_attach_mappings
  }
end

return M
