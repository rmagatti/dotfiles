local M = {}

function M.setup()
  require("gx-extended").setup {
    log_level = vim.log.levels.INFO,
    open_fn = require'lazy.util'.open,
    extensions = {
      {
        patterns = { "*.js", "*.jsx", "*.ts", "*.tsx" },
        name = "npm packages ts/js files",
        match_to_url = function(line_string)
          local package_name = string.match(line_string, "from \"(.*)\"")
          local url = "https://www.npmjs.com/package/" .. package_name

          return url
        end,
      }
      -- {
      --   patterns = { "*.tf" },
      --   name = "terraform modules",
      --   match_to_url = function(line_string)
      --     local module_name = string.match(line_string, "s3::.*/modules/([^/].*)/.*.zip")
      --     local url = "https://github.com/neofinancial/terraform-modules/tree/master/modules/" .. module_name

      --     return url
      --   end,
      -- },
      -- {
      --   patterns = { "**/Projects/Neo/**" },
      --   name = "neo sourcegraph",
      --   match_to_url = function(line_string)
      --     local row_col = vim.api.nvim_win_get_cursor(0)
      --     local relative_path = vim.fn.expand "%"
      --     local proj_name = require("auto-session.lib").current_session_name()

      --     local url = "https://neofinancial.sourcegraph.com/github.com/neofinancial/"
      --       .. proj_name
      --       .. "/-/blob/"
      --       .. relative_path
      --       .. "?L"
      --       .. tostring(row_col[1])

      --     return url
      --   end,
      -- },
    },
  }
end

return M
