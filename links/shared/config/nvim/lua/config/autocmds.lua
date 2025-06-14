-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- yank to system clip
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator == "y" then
      vim.fn.setreg("+", vim.fn.getreg('"'))
    end
  end,
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Create groups
local folding_group = augroup("vimrc", { clear = true })
-- local folds_group = augroup("persistent_folds", { clear = true }) -- if you want folds

-- Filetype detection
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tex",
  command = "set filetype=tex",
})

-- Center cursor on InsertEnter
autocmd("InsertEnter", {
  pattern = "*",
  command = "normal! zz",
})

-- Spellcheck for writing files
autocmd("FileType", {
  pattern = { "tex", "txt", "latex", "markdown" },
  command = "setlocal spell spelllang=en_us",
})

-- Go formatting
autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format({ async = true })
    vim.cmd("silent! lua OrganizeGOImports(400)")
  end,
})

-- Indentation-based folding
autocmd("BufReadPre", {
  pattern = "*",
  group = folding_group,
  command = "setlocal foldmethod=indent",
})

autocmd("BufWinEnter", {
  pattern = "*",
  group = folding_group,
  command = "if &foldmethod == 'indent' | setlocal foldmethod=manual | endif",
})

