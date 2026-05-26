---@class NullLsBuiltin
---@field with fun(opts: table): NullLsBuiltin

---@class NullLsBuiltins
---@field code_actions table<string, NullLsBuiltin>
---@field diagnostics table<string, NullLsBuiltin>
---@field formatting table<string, NullLsBuiltin>

---@class NullLs
---@field builtins NullLsBuiltins
---@field setup fun(opts: table)

---@type NullLs
local null_ls = require "null-ls"
local sql_dialect = require "configs.sql_dialect"

---@type NullLsBuiltins
local b = null_ls.builtins

---@type NullLsBuiltin[]
local sources = {
  -- Web / data
  b.formatting.prettier.with {
    filetypes = {
      "astro",
      "css",
      "graphql",
      "handlebars",
      "html",
      "htmlangular",
      "javascript",
      "javascriptreact",
      "json",
      "json5",
      "jsonc",
      "less",
      "markdown",
      "markdown.mdx",
      "scss",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
      "yaml",
    },
  },
  b.formatting.sqlfluff.with {
    filetypes = { "sql", "mysql" },
    extra_args = sql_dialect.extra_args,
    timeout = 15000,
  },
  b.diagnostics.sqlfluff.with {
    filetypes = { "sql", "mysql" },
    extra_args = sql_dialect.extra_args,
    timeout = 15000,
  },
  b.diagnostics.stylelint.with { timeout = 10000 },
  b.diagnostics.vacuum.with { filetypes = { "yaml" } },

  -- Lua
  b.formatting.stylua,
  b.diagnostics.selene,

  -- Python
  b.diagnostics.mypy.with { timeout = 12000 },

  -- Go
  b.formatting.goimports,
  b.formatting.gofumpt,
  b.diagnostics.revive,

  -- C / C++ / Proto
  b.formatting.clang_format.with { filetypes = { "c", "cpp", "cuda" } },
  b.formatting.buf.with { filetypes = { "proto" } },
  b.diagnostics.buf.with { filetypes = { "proto" } },

  -- Shell / CI / containers
  b.formatting.shfmt.with { filetypes = { "bash", "sh", "zsh" } },
  b.diagnostics.actionlint,
  b.diagnostics.hadolint.with { timeout = 10000 },

  -- Markdown / diagrams
  b.diagnostics.markdownlint.with { timeout = 10000 },
  b.formatting.d2_fmt,
}

null_ls.setup {
  debug = false,
  sources = sources,
  default_timeout = 10000,
  debounce = 1000,
  update_in_insert = false,
}

sql_dialect.setup()
