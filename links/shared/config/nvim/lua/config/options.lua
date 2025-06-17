-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.wrap = true
vim.g.autoformat = false
vim.g.fixendofline = false

-- use system clipboard
vim.opt.clipboard = "unnamedplus"

-- force vim to use unix style line endings
vim.opt.fileformats = { "unix", "dos", "mac" }

-- replace tabs with 3 spaces
-- vim.opt.expandtab = true
-- vim.opt.tabstop = 3
-- vim.opt.shiftwidth = 3

