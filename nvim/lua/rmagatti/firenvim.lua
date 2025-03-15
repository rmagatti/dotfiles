if not vim.g.started_by_firenvim then
  return
end

vim.o.guifont = "JetBrainsMono Nerd Font:h16"
vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline  = "neovim",
      content  = "text",
      priority = 0,
      selector = "textarea",
      takeover = "never"
    }
  }
}

vim.api.nvim_create_autocmd({ "UIEnter" }, {
  ---@diagnostic disable-next-line: unused-local
  callback = function(event)
    local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
    if client ~= nil and client.name == "Firenvim" then
      vim.o.laststatus = 0
      vim.o.guifont = "JetBrainsMono Nerd Font:h16"
    end
  end,
})
