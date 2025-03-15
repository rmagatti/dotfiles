require("auto-session").setup {
  log_level = vim.log.levels.INFO,
  suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  use_git_branch = false,
}

vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
  noremap = true,
})
