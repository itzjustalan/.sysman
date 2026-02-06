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


-- force nvim to use osc52 (esc seq to pass to terminal)
-- bypasses system clipboard (remove if not ssh)
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}


-- replace tabs with 3 spaces
-- vim.opt.expandtab = true
-- vim.opt.tabstop = 3
-- vim.opt.shiftwidth = 3

