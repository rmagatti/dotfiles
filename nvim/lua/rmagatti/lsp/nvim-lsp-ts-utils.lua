local M = {}

local ts_utils_settings = {
  debug = false,
  disable_commands = false,
  enable_import_on_completion = false,

  -- import all
  import_all_timeout = 5000, -- ms
  -- lower numbers = higher priority
  import_all_priorities = {
    same_file = 1, -- add to existing import statement
    local_files = 2, -- git files or files with relative path markers
    buffer_content = 3, -- loaded buffer content
    buffers = 4, -- loaded buffer names
  },
  import_all_scan_buffers = 100,
  import_all_select_source = false,

  -- filter diagnostics
  filter_out_diagnostics_by_severity = {},
  filter_out_diagnostics_by_code = { 80001 },

  -- inlay hints
  auto_inlay_hints = false,
  inlay_hints_highlight = "Comment",

  -- update imports on file move
  update_imports_on_move = true,
  require_confirmation_on_move = true,
  watch_dir = nil,

  -- Null-ls setup seems to be working, so setting this to false.
  eslint_enable_diagnostics = false,
  eslint_enable_code_actions = false,
}

M.setup = function(on_attach)
  local ts_utils = require "nvim-lsp-ts-utils"

  local opts = {
    init_options = vim.tbl_deep_extend("force", ts_utils.init_options, {
      preferences = {
        importModuleSpecifierPreference = "relative",
      },
    }),
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      client.resolved_capabilities.document_formatting = false

      ts_utils.setup(ts_utils_settings)
      ts_utils.setup_client(client)
    end,
    flags = {
      debounce_text_changes = 150,
    },
  }

  return opts
end

return M
