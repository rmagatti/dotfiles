local M = {}

M.setup = function()
  -- -- copilot.vim configs
  -- vim.g.copilot_filetypes = {
  --   ["*"] = false,
  --   ["c"] = true,
  --   ["cpp"] = true,
  --   ["c++"] = true,
  --   ["c#"] = true,
  --   ["csharp"] = true,
  --   ["cs"] = true,
  --   ["css"] = true,
  --   ["html"] = true,
  --   ["js"] = true,
  --   ["javascript"] = true,
  --   ["typescript"] = true,
  --   ["json"] = true,
  --   ["lua"] = true,
  --   ["php"] = true,
  --   ["py"] = true,
  --   ["python"] = true,
  --   ["ruby"] = true,
  --   ["rust"] = true,
  --   ["sh"] = true,
  --   ["vim"] = true,
  --   ["yaml"] = true,
  -- }

  -- vim.cmd [[imap <silent><script><expr> <C-K> copilot#Accept("\<CR>")]]
  -- vim.cmd [[let g:copilot_no_tab_map = v:true]]

  -- -- copilot.lua configs
  require("copilot").setup {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-j>",
        next = "<C-k>",
        prev = "<C-l>",
      },
    },
    copilot_node_command = "node",
    panel = { enabled = false },
  }
end

return M
