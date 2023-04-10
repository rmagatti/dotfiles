require("auto-session").setup {
  log_level = vim.log.levels.ERROR,
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  auto_session_use_git_branch = false,
  auto_session_enable_last_session = false,

  session_lens = {
    theme_conf = { border = true },
    previewer = false,
  },
}

vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
  noremap = true,
})
