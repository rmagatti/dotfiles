require("auto-session").setup {
  log_level = vim.log.levels.INFO,
  suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  use_git_branch = true,
  show_auto_restore_notif = true,
  session_lens = {
    load_on_setup = false
  }
}

vim.keymap.set("n", "<C-s>", function()
  require("telescope").load_extension "session-lens"
  require("auto-session.session-lens").search_session({})
end, {
  noremap = true,
})
