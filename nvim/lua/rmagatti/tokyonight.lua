-- Example config in Lua
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "terminal", "plug" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

vim.cmd [[colorscheme tokyonight]]

-- -- Load the colorscheme
-- vim.defer_fn(function()
--   vim.cmd[[
--     colorscheme tokyonight
--   ]]
-- end, 40)
