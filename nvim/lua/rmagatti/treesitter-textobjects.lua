-- Initialize nvim-treesitter-textobjects with new API
require("nvim-treesitter-textobjects").setup {
  select = {
    enable = true,
    lookahead = true,
  },
  swap = {
    enable = true,
  },
  move = {
    enable = true,
    set_jumps = true,
  },
}

-- Setup keymaps for text object selection
local select = require("nvim-treesitter-textobjects.select")
local swap = require("nvim-treesitter-textobjects.swap")
local move = require("nvim-treesitter-textobjects.move")

-- Select textobjects
vim.keymap.set({ "x", "o" }, "af", function()
  select.select_textobject("@function.outer", "textobjects")
end, { desc = "[TO] Select outer part of a function region" })

vim.keymap.set({ "x", "o" }, "if", function()
  select.select_textobject("@function.inner", "textobjects")
end, { desc = "[TO] Select inner part of a function region" })

vim.keymap.set({ "x", "o" }, "as", function()
  select.select_textobject("@local.scope", "locals")
end, { desc = "[TO] Select scope region" })

vim.keymap.set({ "x", "o" }, "il", function()
  select.select_textobject("@loop.inner", "textobjects")
end, { desc = "[TO] Select inner part of a loop region" })

vim.keymap.set({ "x", "o" }, "al", function()
  select.select_textobject("@loop.outer", "textobjects")
end, { desc = "[TO] Select outer part of a loop region" })

vim.keymap.set({ "x", "o" }, "ib", function()
  select.select_textobject("@block.inner", "textobjects")
end, { desc = "[TO] Select inner part of a block region" })

vim.keymap.set({ "x", "o" }, "ab", function()
  select.select_textobject("@block.outer", "textobjects")
end, { desc = "[TO] Select outer part of a block region" })

vim.keymap.set({ "x", "o" }, "icl", function()
  select.select_textobject("@class.inner", "textobjects")
end, { desc = "[TO] Select inner part of a class region" })

vim.keymap.set({ "x", "o" }, "acl", function()
  select.select_textobject("@class.outer", "textobjects")
end, { desc = "[TO] Select outer part of a class region" })

vim.keymap.set({ "x", "o" }, "ic", function()
  select.select_textobject("@call.inner", "textobjects")
end, { desc = "[TO] Select inner part of a call region" })

vim.keymap.set({ "x", "o" }, "ac", function()
  select.select_textobject("@call.outer", "textobjects")
end, { desc = "[TO] Select outer part of a call region" })

vim.keymap.set({ "x", "o" }, "acm", function()
  select.select_textobject("@comment.outer", "textobjects")
end, { desc = "[TO] Select outer part of a comment region" })

vim.keymap.set({ "x", "o" }, "icd", function()
  select.select_textobject("@conditional.inner", "textobjects")
end, { desc = "[TO] Select inner part of a conditional region" })

vim.keymap.set({ "x", "o" }, "acd", function()
  select.select_textobject("@conditional.outer", "textobjects")
end, { desc = "[TO] Select outer part of a conditional region" })

vim.keymap.set({ "x", "o" }, "ir", function()
  select.select_textobject("@parameter.inner", "textobjects")
end, { desc = "[TO] Select inner part of a parameter region" })

vim.keymap.set({ "x", "o" }, "ar", function()
  select.select_textobject("@parameter.outer", "textobjects")
end, { desc = "[TO] Select outer part of a parameter region" })

vim.keymap.set({ "x", "o" }, "a=", function()
  select.select_textobject("@assignment.outer", "textobjects")
end, { desc = "[TO] Select outer part of an assignment region" })

vim.keymap.set({ "x", "o" }, "i=", function()
  select.select_textobject("@assignment.inner", "textobjects")
end, { desc = "[TO] Select inner part of an assignment region" })

vim.keymap.set({ "x", "o" }, "ia", function()
  select.select_textobject("@attribute.inner", "textobjects")
end, { desc = "[TO] Select inner part of an attribute region" })

vim.keymap.set({ "x", "o" }, "aa", function()
  select.select_textobject("@attribute.outer", "textobjects")
end, { desc = "[TO] Select outer part of an attribute region" })

vim.keymap.set({ "x", "o" }, "ire", function()
  select.select_textobject("@return.inner", "textobjects")
end, { desc = "[TO] Select inner part of a return region" })

vim.keymap.set({ "x", "o" }, "are", function()
  select.select_textobject("@return.outer", "textobjects")
end, { desc = "[TO] Select outer part of a return region" })

vim.keymap.set({ "x", "o" }, "in", function()
  select.select_textobject("@number.inner", "textobjects")
end, { desc = "[TO] Select number" })

-- Swap textobjects
vim.keymap.set("n", "<leader>s;", function()
  swap.swap_next("@parameter.inner")
end, { desc = "[TO] Swap with next parameter" })

vim.keymap.set("n", "<leader>sj", function()
  swap.swap_previous("@parameter.inner")
end, { desc = "[TO] Swap with previous parameter" })

-- Move to next/previous textobjects
vim.keymap.set({ "n", "x", "o" }, "]f", function()
  move.goto_next_start("@function.outer", "textobjects")
end, { desc = "[TO] Next function start" })

vim.keymap.set({ "n", "x", "o" }, "]F", function()
  move.goto_next_end("@function.outer", "textobjects")
end, { desc = "[TO] Next function end" })

vim.keymap.set({ "n", "x", "o" }, "[f", function()
  move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "[TO] Previous function start" })

vim.keymap.set({ "n", "x", "o" }, "[F", function()
  move.goto_previous_end("@function.outer", "textobjects")
end, { desc = "[TO] Previous function end" })

vim.keymap.set({ "n", "x", "o" }, "]c", function()
  move.goto_next_start("@class.outer", "textobjects")
end, { desc = "[TO] Next class start" })

vim.keymap.set({ "n", "x", "o" }, "]C", function()
  move.goto_next_end("@class.outer", "textobjects")
end, { desc = "[TO] Next class end" })

vim.keymap.set({ "n", "x", "o" }, "[c", function()
  move.goto_previous_start("@class.outer", "textobjects")
end, { desc = "[TO] Previous class start" })

vim.keymap.set({ "n", "x", "o" }, "[C", function()
  move.goto_previous_end("@class.outer", "textobjects")
end, { desc = "[TO] Previous class end" })
