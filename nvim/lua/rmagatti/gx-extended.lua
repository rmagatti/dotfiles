local M = {}

function M.setup()
  require("gx-extended").setup {
    log_level = vim.log.levels.ERROR,
    extensions = {
      {
        autocmd_pattern = { "*.tf" },
        match_to_url = function(line_string)
          local module_name = string.match(line_string, "s3::.*/modules/([^/].*)/.*.zip")
          local url = "https://github.com/neofinancial/terraform-modules/tree/master/modules/" .. module_name

          return url
        end,
      },
    },
  }
end

return M
