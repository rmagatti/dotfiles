local M = {}

M.setup = function()
  require("telescope").load_extension "session-lens"
end

return M
