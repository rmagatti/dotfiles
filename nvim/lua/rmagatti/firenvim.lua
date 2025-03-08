vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline  = "neovim",
      content  = "text",
      priority = 0,
      selector = "textarea",
      takeover = "always"
    }
  }
}

vim.api.nvim_create_autocmd({ "UIEnter" }, {
  callback = function(event)
    local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
    if client ~= nil and client.name == "Firenvim" then
      vim.o.laststatus = 0
      vim.o.guifont = "JetBrains_Mono:h16"
    end
  end,
})
