return {
  swap = {
    enable = true,
    swap_next = {
      ["<leader>s;"] = "@parameter.inner",
    },
    swap_previous = {
      ["<leader>sj"] = "@parameter.inner",
    },
  },
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
      ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
      ["as"] = { query = "@scope", query_group = "locals", desc = "Select inner part of a scope region" },
      ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },
      ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
      ["ib"] = { query = "@block.inner", desc = "Select inner part of a block region" },
      ["ab"] = { query = "@block.outer", desc = "Select outer part of a block region" },
      ["icl"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      ["acl"] = { query = "@class.outer", desc = "Select outer part of a class region" },
      ["acm"] = { query = "@comment.outer", desc = "Select outer part of a comment region" },
      ["icd"] = { query = "@conditional.inner", desc = "Select inner part of a conditional region" },
      ["acd"] = { query = "@conditional.outer", desc = "Select outer part of a conditional region" },
      ["ir"] = { query = "@parameter.inner", desc = "Select inner part of a parameter region" },
      ["ar"] = { query = "@parameter.outer", desc = "Select outer part of a parameter region" },
      ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment region" },
      ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment region" },
    }
  },
}
