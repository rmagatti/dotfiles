require("nvim-treesitter").setup {
  ensure_installed = { "lua", "typescript", "terraform", "svelte", "html", "css", "json", "bash", "yaml", "markdown", "markdown_inline", "rust", "gitcommit" },
  sync_install = false,
  ignore_install = { "" },
  auto_install = true,
  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  },

  -- textsubjects = require("rmagatti.treesitter-textsubjects"), -- Disabled: incompatible with main branch
  incremental_selection = require("rmagatti.treesitter-incremental-selection"),

  -- TODO: Figure out how to use move
  move = require("rmagatti.treesitter-move"),
}
