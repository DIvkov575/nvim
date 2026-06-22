vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

vim.keymap.set("n", "<leader>tt", function()
  vim.cmd("botright 15split | terminal")
  vim.bo.buflisted = false
  vim.cmd("startinsert")
end, { desc = "Open terminal (bottom)" })

vim.keymap.set({ "n", "t" }, "<leader>tv", function()
  vim.cmd("vsplit | terminal")
  vim.bo.buflisted = false
  vim.cmd("startinsert")
end, { desc = "Terminal split vertical" })

vim.keymap.set({ "n", "t" }, "<leader>th", function()
  vim.cmd("split | terminal")
  vim.bo.buflisted = false
  vim.cmd("startinsert")
end, { desc = "Terminal split horizontal" })

-- Exit terminal mode easily
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<leader>tx", function()
  vim.api.nvim_win_close(0, true)
end, { desc = "Close terminal window" })

-- Navigate between splits from normal and terminal mode
vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>", { desc = "Move to left split" })
vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>", { desc = "Move to below split" })
vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>", { desc = "Move to above split" })
vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>", { desc = "Move to right split" })
