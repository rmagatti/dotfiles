require("auto-session").setup {
  log_level = "info",
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  auto_session_use_git_branch = false,

  cwd_change_handling = false, -- Should be false if you use session-lens

  auto_session_enable_last_session = false,
  -- cwd_change_handling = {
  --   restore_upcoming_session = true,
  --   -- pre_cwd_changed_hook = nil,
  --   post_cwd_changed_hook = function()
  --     require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
  --   end,
  -- },
}
