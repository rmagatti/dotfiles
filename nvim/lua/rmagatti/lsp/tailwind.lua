local M = {}

function M.setup()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  -- Default filetypes from nvim-lspconfig's tailwindcss config, plus rust
  local default_filetypes = {
    -- html
    'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html',
    'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml',
    'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'htmlangular', 'html-eex',
    'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk',
    'nunjucks', 'php', 'razor', 'slim', 'twig',
    -- css
    'css', 'less', 'postcss', 'sass', 'scss', 'stylus', 'sugarss',
    -- js/ts
    'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact',
    -- mixed
    'vue', 'svelte', 'templ',
  }

  local filetypes = vim.deepcopy(default_filetypes)
  table.insert(filetypes, 'rust')

  local include_languages = {
    eelixir = 'html-eex',
    eruby = 'erb',
    templ = 'html',
    htmlangular = 'html',
    rust = 'html',
    ["*.rs"] = 'html',
  }

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    filetypes = filetypes,
    settings = {
      tailwindCSS = {
        includeLanguages = include_languages,
      },
    },
  }

  vim.lsp.config("tailwindcss", opts)
  vim.lsp.enable("tailwindcss")
end

return M
