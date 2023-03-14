local M = {}

M.setup = function()
  vim.g.copilot_filetypes = {
    ["*"] = false,
    ["c"] = true,
    ["cpp"] = true,
    ["c++"] = true,
    ["c#"] = true,
    ["csharp"] = true,
    ["cs"] = true,
    ["css"] = true,
    ["html"] = true,
    ["js"] = true,
    ["javascript"] = true,
    ["typescript"] = true,
    ["json"] = true,
    ["lua"] = true,
    ["php"] = true,
    ["py"] = true,
    ["python"] = true,
    ["ruby"] = true,
    ["rust"] = true,
    ["sh"] = true,
    ["vim"] = true,
    ["yaml"] = true,
  }

  -- vim.cmd [[imap <silent><script><expr> <C-K> copilot#Accept("\<CR>")]]
  -- vim.cmd [[let g:copilot_no_tab_map = v:true]]
end

return M
