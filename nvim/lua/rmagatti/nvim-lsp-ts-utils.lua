-- TS Utils
local ts_utils = require("nvim-lsp-ts-utils")
local mappings = require("rmagatti.lsp-mappings")
local signature = require("rmagatti.lsp-signature")
-- local lsp_status = require('lsp-status')

require("null-ls").config({})
require("lspconfig")["null-ls"].setup({})

require("lspconfig").typescript.setup({
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "relative",
		},
	},
	on_attach = function(client, bufnr)
		-- client.resolved_capabilities.document_formatting = false

		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = false,

			-- import all
			import_all_timeout = 3000, -- ms
			import_all_priorities = {
				buffers = 4, -- loaded buffer names
				buffer_content = 3, -- loaded buffer content
				local_files = 2, -- git files or files with relative path markers
				same_file = 1, -- add to existing import statement
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,

			-- eslint
			eslint_enable_code_actions = true,
			eslint_enable_disable_comments = true,
			eslint_bin = "eslint_d",
			eslint_config_fallback = nil,
			eslint_enable_diagnostics = true,
			eslint_show_rule_id = false,

			-- formatting
			enable_formatting = true,
			formatter = "prettier",
			formatter_config_fallback = nil,

			-- update imports on file move
			update_imports_on_move = true,
			require_confirmation_on_move = true,
			watch_dir = nil,
		})

		ts_utils.setup_client(client)

		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>i", ":TSLspOrganize<CR>", { silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fc", ":TSLspFixCurrent<CR>", { silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rf", ":TSLspRenameFile<CR>", { silent = true })
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ia", ":TSLspImportAll<CR>", { silent = true })

		mappings.on_attach(client, bufnr)
		signature.on_attach()
		-- lsp_status.on_attach(client)
	end,
	-- capabilities = lsp_status.capabilities,
})
