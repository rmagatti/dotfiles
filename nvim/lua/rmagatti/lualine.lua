local function current_session()
  return require("auto-session.lib").current_session_name(true)
end

require("lualine").setup {
  options = {
    theme = "kanagawa",
  },
  extensions = { "fzf", "fugitive" },
  sections = {
    lualine_c = { current_session },
    lualine_a = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
  },

  -- TODO: Uncomment this when neovim/neovim#19458 is closed
  -- winbar = {
  --   lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 1 } },
  --   lualine_c = { { 'aerial', sep = ' ❯ ' } },
  -- },
  -- inactive_winbar = {
  --   lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 1 } },
  -- }
}
