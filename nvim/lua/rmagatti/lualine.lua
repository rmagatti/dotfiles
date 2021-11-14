local function current_session()
	return require("auto-session-library").current_session_name()
end

require("lualine").setup({
	options = {
		theme = "tokyonight",
	},
	extensions = { "fzf", "fugitive" },
	sections = { lualine_c = { current_session } },
})
