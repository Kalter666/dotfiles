local M = {}

local installed_or_pending = {}

local servers = {
  angularls = {
    filetypes = { "html", "typescript", "typescriptreact" },
    root_markers = { "angular.json" },
  },
  buf_ls = {
    filetypes = { "proto" },
    root_markers = { "buf.yaml", "buf.work.yaml" },
  },
  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt" },
  },
  cmake = {
    filetypes = { "cmake" },
    root_markers = { "CMakeLists.txt" },
  },
  cssls = {
    filetypes = { "css", "scss", "less" },
  },
  docker_compose_language_service = {
    filetypes = { "yaml.docker-compose" },
    root_markers = { "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml" },
  },
  dockerls = {
    filetypes = { "dockerfile" },
  },
  eslint = {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    root_markers = {
      ".eslintrc",
      ".eslintrc.cjs",
      ".eslintrc.js",
      ".eslintrc.json",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      "eslint.config.cjs",
      "eslint.config.js",
      "eslint.config.mjs",
    },
  },
  gopls = {
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.mod", "go.work" },
  },
  hls = {
    filetypes = { "haskell", "cabal", "lhaskell", "cabalproject" },
    root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal" },
  },
  html = {
    filetypes = { "html" },
  },
  jsonls = {
    filetypes = { "json", "jsonc" },
  },
  lua_ls = {
    filetypes = { "lua" },
  },
  marksman = {
    filetypes = { "markdown", "markdown.mdx" },
  },
  protols = {
    filetypes = { "proto" },
  },
  pyright = {
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json" },
  },
  ruff = {
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml" },
  },
  rust_analyzer = {
    filetypes = { "rust" },
    root_markers = { "Cargo.toml" },
  },
  taplo = {
    filetypes = { "toml" },
  },
  typos_lsp = {
    filetypes = { "gitcommit", "markdown", "text" },
  },
  vtsls = {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
  },
  yamlls = {
    filetypes = { "yaml", "yaml.docker-compose" },
  },
  zls = {
    filetypes = { "zig", "zir" },
    root_markers = { "build.zig" },
  },
}

local function has_filetype(config, filetype)
  return vim.tbl_contains(config.filetypes, filetype)
end

local function has_project_marker(config, path)
  if not config.root_markers then
    return true
  end

  local exact_markers = {}
  local suffix_markers = {}

  for _, marker in ipairs(config.root_markers) do
    if marker:sub(1, 2) == "*." then
      table.insert(suffix_markers, marker:sub(2))
    else
      table.insert(exact_markers, marker)
    end
  end

  if #exact_markers > 0 and vim.fs.root(path, exact_markers) ~= nil then
    return true
  end

  if #suffix_markers == 0 then
    return false
  end

  local dirname = vim.fs.dirname(path)

  for dir in vim.fs.parents(dirname) do
    for name in vim.fs.dir(dir) do
      for _, suffix in ipairs(suffix_markers) do
        if name:sub(-#suffix) == suffix then
          return true
        end
      end
    end
  end

  return false
end

local function install(server)
  if installed_or_pending[server] then
    return
  end

  local ok_registry, registry = pcall(require, "mason-registry")
  local ok_mappings, mappings = pcall(require, "mason-lspconfig.mappings")

  if not ok_registry or not ok_mappings then
    return
  end

  local package_name = mappings.get_mason_map().lspconfig_to_package[server]
  if not package_name then
    return
  end

  local ok_pkg, package = pcall(registry.get_package, package_name)
  if not ok_pkg or package:is_installed() or package:is_installing() then
    installed_or_pending[server] = true
    return
  end

  installed_or_pending[server] = true
  package:install({}, vim.schedule_wrap(function(success)
    if success then
      vim.notify(("Installed LSP server: %s"):format(server), vim.log.levels.INFO)
      vim.lsp.enable(server)
      pcall(vim.cmd.LspStart, server)
    else
      installed_or_pending[server] = nil
      vim.notify(("Failed to install LSP server: %s. Check :MasonLog"):format(server), vim.log.levels.ERROR)
    end
  end))
end

function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("LspAutoInstall", { clear = true }),
    callback = function(args)
      local path = vim.api.nvim_buf_get_name(args.buf)

      if path == "" then
        return
      end

      for server, config in pairs(servers) do
        if has_filetype(config, vim.bo[args.buf].filetype) and has_project_marker(config, path) then
          install(server)
        end
      end
    end,
  })
end

return M
