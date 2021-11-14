local M = {}

M.conf = {
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	-- If you want to hook lspsaga or other signature handler, pls set to false
	-- doc_lines = 10, -- only show one line of comment set to 0 if you do not want API comments be shown

	hint_enable = true, -- virtual hint enable
	hint_prefix = "🐼 ", -- Panda for parameter
	hint_scheme = "String",

	handler_opts = {
		-- When updating Neovim, check if https://github.com/neovim/neovim/pull/14707 was merged.
		-- If not, make the change in /usr/local/Cellar/neovim/HEAD-*/share/nvim/runtime/lua/vim/lsp/util.lua:42
		border = "single", -- double, single, shadow, none
	},

	floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
	use_lspsaga = false, -- set to true if you want to use lspsaga popup
	-- hi_parameter = "Search", -- how your parameter will be highlight
	max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
	-- to view the hiding contents
	max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
}

M.on_attach = function()
	require("lsp_signature").on_attach(M.conf)
end

return M
