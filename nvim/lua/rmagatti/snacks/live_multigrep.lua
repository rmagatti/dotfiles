local M = {}

-- Note: Snacks picker has built-in grep with pattern support
-- The original multigrep functionality (search  glob_pattern) 
-- can be partially achieved with Snacks.picker.grep()
-- 
-- For the original behavior where you could do "search_term  *.lua"
-- you may need to use Snacks grep with glob patterns or file filters

M.live_multigrep = function()
  local Snacks = require("snacks")
  
  -- Snacks picker's grep supports patterns
  -- For multigrep-like behavior, users can use the picker's filtering
  Snacks.picker.grep({
    -- The picker has built-in filtering capabilities
    -- Users can filter results using the picker UI
  })
end

M.setup = function()
  -- You can map this if you want the multigrep functionality
  -- vim.keymap.set("n", "<leader>mg", M.live_multigrep, { desc = "Multi grep" })
end

return M
