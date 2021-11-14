local refactor = require("refactoring")
refactor.setup()

_G.list_refactors = function()
	local opts = require("telescope.themes").get_cursor() -- set personal telescope options

	require("telescope.pickers").new(opts, {
		prompt_title = "Refactors",
		finder = require("telescope.finders").new_table({
			results = require("refactoring").get_refactors(),
		}),
		sorter = require("telescope.config").values.generic_sorter(opts),
		attach_mappings = function()
			require("telescope.actions").select_default:replace(function(prompt_bufnr)
				local content = require("telescope.actions.state").get_selected_entry()
				require("telescope.actions").close(prompt_bufnr)
				require("refactoring").refactor(content.value)
			end)
			return true
		end,
	}):find()
end
