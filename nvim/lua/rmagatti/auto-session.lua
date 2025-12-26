require("auto-session").setup {
  log_level = vim.log.levels.INFO,
  suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  use_git_branch = false,
  show_auto_restore_notif = true,
  picker = "snacks", -- Use Snacks picker instead of Telescope
}

vim.keymap.set("n", "<leader>ss", function()
  require("auto-session.session-lens").search_session()
end, {
  noremap = true,
  desc = "Search sessions with Snacks picker"
})
