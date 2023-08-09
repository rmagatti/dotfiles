local M = {}

M.setup = function()
  require("lint").linters_by_ft = {
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    javascript = { "eslint_d" },
  }

  vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })
end

return M
