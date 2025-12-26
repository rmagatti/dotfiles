local M = {}

function M.setup()
  require("gx-extended").setup {
    log_level = vim.log.levels.INFO,
    open_fn = require('lazy.util').open,

    -- Enable all optional features
    enable_npm_imports = true,
    enable_github_file_line = true,
    enable_jira_tickets = false, -- Set to true if you use Jira
    enable_linear_issues = true, -- Set to true if you use Linear

    extensions = {
      -- Custom: Organization-specific GitHub permalinks with branch detection
      {
        patterns = { "**/Projects/Montra/**" },
        name = "Montra-Interactive GitHub",
        match_to_url = function(line_string)
          local row_col = vim.api.nvim_win_get_cursor(0)
          local relative_path = vim.fn.expand("%")
          local proj_name = require("auto-session.lib").current_session_name()

          -- Extract just the project name from the path
          proj_name = string.match(proj_name, ".*/(.*)")

          -- Fetch the current git branch
          local handle = io.popen("git rev-parse --abbrev-ref HEAD")
          local current_branch = handle and handle:read("*a"):gsub("%s+", "")

          if handle then
            handle:close()
          end

          local url = "https://github.com/Montra-Interactive/"
              .. proj_name
              .. "/blob/"
              .. current_branch
              .. "/"
              .. relative_path
              .. "#L"
              .. tostring(row_col[1])

          return url
        end,
      },

      -- You can add more custom extensions here
      -- Example: Internal terraform modules (currently commented in your config)
      -- {
      --   patterns = { "**/*.tf" },
      --   name = "Internal Terraform Modules",
      --   match_to_url = function(line_string)
      --     local module_name = string.match(line_string, "s3::.*/modules/([^/].*)/.*.zip")
      --     if module_name then
      --       return "https://github.com/yourcompany/terraform-modules/tree/master/modules/" .. module_name
      --     end
      --   end,
      -- },
    },
  }

  -- Optional: Configure issue tracking systems
  -- Uncomment and set these if you use Jira or Linear

  -- vim.g.gx_jira_url = "https://yourcompany.atlassian.net"
  -- or use environment variable: export JIRA_URL="https://yourcompany.atlassian.net"

  -- vim.g.gx_linear_team = "your-team-slug"
  -- or use environment variable: export LINEAR_TEAM="your-team-slug"
end

return M
