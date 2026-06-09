vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

-- Uncomment these if you want Oil to fully replace netrw.
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  signs = true,
  severity_sort = true,
})
