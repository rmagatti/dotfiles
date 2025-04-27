vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
-- Default to treesitter folding but allow LSP to override
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = 'v:lua.CustomFoldText()'

function _G.CustomFoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  local foldsize = vim.v.foldend - vim.v.foldstart + 1
  local suffix = " (" .. foldsize .. " lines)"

  -- Check for different types of opening brackets at the end
  local bracket_pairs = {
    ["{"] = "}",
    ["["] = "]",
    ["("] = ")",
    ["<"] = ">"
  }

  -- Find the last non-whitespace character
  local last_char = line:match("([^%s])%s*$")

  if last_char and bracket_pairs[last_char] then
    return line .. suffix .. " " .. bracket_pairs[last_char]
  else
    return line .. suffix
  end
end

vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})
vim.api.nvim_create_autocmd("LspDetach", { command = "setl foldexpr<" })
