require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local in_tmux = vim.env.TMUX ~= nil
local is_wsl = vim.fn.has "wsl" == 1

if in_tmux and is_wsl then
  -- Neovim 0.12 + tmux on WSL can leave duplicated UI fragments after terminal/tab focus changes.
  vim.opt.termsync = false
end
