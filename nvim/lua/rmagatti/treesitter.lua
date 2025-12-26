require("nvim-treesitter").setup {
  ensure_installed = { "lua", "typescript", "terraform", "svelte", "html", "css", "json", "bash", "yaml", "markdown", "markdown_inline", "rust", "gitcommit", "terraform" },
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'typescript', 'terraform', 'svelte', 'html', 'css', 'json', 'bash', 'yaml', 'markdown', 'rust', "gitcommit", "terraform" },
  callback = function()
    vim.treesitter.start()
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
