local null_ls = require "null-ls"

local b = null_ls.builtins
local sources = {

  -- webdev stuff
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "javascript", "typescript", "json" } },
  b.diagnostics.vacuum,
  b.diagnostics.stylelint,
  -- Luav
  b.formatting.stylua,
  b.diagnostics.selene,

  -- python
  b.diagnostics.mypy,

  -- go
  b.formatting.gofmt,
  b.diagnostics.revive,

  -- other
  b.diagnostics.actionlint,
  b.diagnostics.buf,
  b.diagnostics.hadolint,
  b.diagnostics.markdownlint,
  b.diagnostics.sqlfluff,
  b.formatting.d2_fmt,
}

null_ls.setup {
  debug = false,
  sources = sources,
  debounce = 500,
}
