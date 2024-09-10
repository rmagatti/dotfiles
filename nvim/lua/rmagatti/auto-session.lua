require("auto-session").setup {
  log_level = vim.log.levels.ERROR,
  suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  use_git_branch = false,
  -- no_restore_cmds = {
  --   function()
  --     vim.notify("!!!WASABI!!!", vim.log.levels.DEBUG)
  --   end
  -- }
}

vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
  noremap = true,
})
