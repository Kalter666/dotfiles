local M = {}

local state_file = vim.fn.stdpath "state" .. "/sql-dialects.json"
local align_config = vim.fn.stdpath "config" .. "/lua/configs/sqlfluff-align.cfg"

local dialects = {
  "ansi",
  "athena",
  "bigquery",
  "clickhouse",
  "databricks",
  "db2",
  "duckdb",
  "exasol",
  "greenplum",
  "hive",
  "materialize",
  "mysql",
  "oracle",
  "postgres",
  "redshift",
  "snowflake",
  "soql",
  "sparksql",
  "sqlite",
  "starrocks",
  "teradata",
  "trino",
  "tsql",
  "vertica",
}

---@type table<string, string>
local by_file = {}

local loaded = false

local function load_state()
  if loaded then
    return
  end

  loaded = true

  local lines = vim.fn.filereadable(state_file) == 1 and vim.fn.readfile(state_file) or nil
  if not lines or #lines == 0 then
    return
  end

  local ok, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
  if ok and type(decoded) == "table" then
    by_file = decoded
  end
end

local function save_state()
  vim.fn.mkdir(vim.fn.fnamemodify(state_file, ":h"), "p")
  vim.fn.writefile({ vim.json.encode(by_file) }, state_file)
end

local function path_for(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)

  if name == "" then
    return nil
  end

  return vim.fs.normalize(name)
end

local function label_for(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)

  if name == "" then
    return "buffer"
  end

  return vim.fn.fnamemodify(name, ":t")
end

local function telescope_select(bufnr, on_done)
  local ok_pickers, pickers = pcall(require, "telescope.pickers")
  local ok_finders, finders = pcall(require, "telescope.finders")
  local ok_conf, conf = pcall(require, "telescope.config")
  local ok_actions, actions = pcall(require, "telescope.actions")
  local ok_state, action_state = pcall(require, "telescope.actions.state")
  local ok_themes, themes = pcall(require, "telescope.themes")

  if not (ok_pickers and ok_finders and ok_conf and ok_actions and ok_state and ok_themes) then
    return false
  end

  local current = M.get(bufnr)
  local title = ("SQL dialect: %s"):format(label_for(bufnr))

  if current then
    title = ("%s [%s]"):format(title, current)
  end

  pickers
    .new(themes.get_dropdown {
      prompt_title = title,
      finder = finders.new_table {
        results = dialects,
      },
      sorter = conf.values.generic_sorter {},
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          on_done(selection and selection.value or nil)
        end)

        return true
      end,
    })
    :find()

  return true
end

local function fallback_select(bufnr, on_done)
  vim.ui.select(dialects, {
    prompt = "SQL dialect for " .. label_for(bufnr),
  }, on_done)
end

local function set_sql_indent(bufnr)
  vim.bo[bufnr].expandtab = true
  vim.bo[bufnr].shiftwidth = 2
  vim.bo[bufnr].softtabstop = 2
  vim.bo[bufnr].tabstop = 2
end

---@param bufnr integer
---@param dialect string
function M.set(bufnr, dialect)
  vim.b[bufnr].sql_dialect = dialect

  local path = path_for(bufnr)
  if path then
    load_state()
    by_file[path] = dialect
    save_state()
  end

  vim.notify(("SQL dialect for this file: %s"):format(dialect), vim.log.levels.INFO)
end

---@param bufnr integer?
---@return string?
function M.get(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if vim.b[bufnr].sql_dialect then
    return vim.b[bufnr].sql_dialect
  end

  local path = path_for(bufnr)
  if not path then
    return nil
  end

  load_state()

  local dialect = by_file[path]
  if dialect then
    vim.b[bufnr].sql_dialect = dialect
  end

  return dialect
end

---@param bufnr integer?
---@return string
function M.get_or_default(bufnr)
  return M.get(bufnr) or "ansi"
end

---@param bufnr integer?
---@return string[]
function M.sqlfluff_args(bufnr)
  return { "--dialect", M.get_or_default(bufnr), "--config", align_config }
end

---@param bufnr integer?
---@param force boolean?
function M.select(bufnr, force)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if not force and M.get(bufnr) then
    return
  end

  if vim.b[bufnr].sql_dialect_selecting then
    return
  end

  vim.b[bufnr].sql_dialect_selecting = true

  local on_done = function(choice)
    vim.b[bufnr].sql_dialect_selecting = false

    if choice then
      M.set(bufnr, choice)
    end
  end

  if not telescope_select(bufnr, on_done) then
    fallback_select(bufnr, on_done)
  end
end

function M.extra_args(params)
  local bufnr = params and params.bufnr or vim.api.nvim_get_current_buf()

  return M.sqlfluff_args(bufnr)
end

function M.conform_args(_, ctx)
  return vim.list_extend({
    "fix",
    "--disable-progress-bar",
    "-n",
  }, vim.list_extend(M.sqlfluff_args(ctx.buf), { "-" }))
end

function M.setup()
  vim.api.nvim_create_user_command("SqlDialect", function()
    M.select(vim.api.nvim_get_current_buf(), true)
  end, {
    desc = "Select SQL dialect for the current file",
    force = true,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("SqlDialectSelect", { clear = true }),
    pattern = { "sql", "mysql" },
    callback = function(args)
      set_sql_indent(args.buf)

      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(args.buf) then
          M.select(args.buf, false)
        end
      end)
    end,
  })
end

return M
