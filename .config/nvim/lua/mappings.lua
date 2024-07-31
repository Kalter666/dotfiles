require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>")
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gd", vim.lsp.buf.definition)
map("n", "K", vim.lsp.buf.hover)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "<leader>sh", vim.lsp.buf.signature_help)
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
map("n", "<leader>fg", "<cmd>GrugFar<cr>")
map("n", "<leader>li", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle LSP Inlay Hint" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
