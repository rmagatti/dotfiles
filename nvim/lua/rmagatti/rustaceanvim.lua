local repo_root = vim.fs.normalize("/Users/ronniemagatti/Projects/Montra/frontend-component")
local bff_manifest = repo_root .. "/apps/bff/Cargo.toml"

local function in_repo(path)
  if not path or path == "" then
    return false
  end

  path = vim.fs.normalize(path)

  return path == repo_root or vim.startswith(path, repo_root .. "/")
end

local function rust_analyzer_settings(root_dir, default_settings)
  local settings = vim.deepcopy(default_settings or {})
  local bufname = vim.api.nvim_buf_get_name(0)

  if not in_repo(root_dir) and not in_repo(bufname) then
    return settings
  end

  settings["rust-analyzer"] = vim.tbl_deep_extend("force", settings["rust-analyzer"] or {}, {
    linkedProjects = { bff_manifest },
    cargo = {
      allTargets = false,
      targetDir = true,
      buildScripts = {
        enable = true,
      },
    },
    check = {
      command = "check",
      allTargets = false,
      workspace = false,
    },
    diagnostics = {
      experimental = {
        enable = true,
      },
    },
    procMacro = {
      enable = true,
    },
    cachePriming = {
      enable = false,
    },
    files = {
      exclude = { "node_modules", ".next", "target", "apps/bff/target" },
    },
  })

  return settings
end

return {
  server = {
    settings = rust_analyzer_settings,
  },
}
