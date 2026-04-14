require "nvchad.autocmds"

local in_tmux = vim.env.TMUX ~= nil
local is_wsl = vim.fn.has "wsl" == 1

if in_tmux and is_wsl then
  local group = vim.api.nvim_create_augroup("tmux_wsl_redraw_fix", { clear = true })

  vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
    group = group,
    callback = function()
      vim.schedule(function()
        vim.cmd "redraw!"
      end)
    end,
  })
end
