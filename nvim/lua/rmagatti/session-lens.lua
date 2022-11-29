require("auto-session.session-lens").setup {
  path_display = { "shorten" },
  theme_conf = { border = true },
  previewer = false,
  config = function()
    vim.keymap.set("n", "<C-s>", require("session-lens").search_session, {
      noremap = true,
    })
  end,
}
