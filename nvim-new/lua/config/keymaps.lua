-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    local dopts = { noremap = true, silent = true, desc = "--" }
    if type(opts) == "string" then
      opts = { noremap = true, silent = true, desc = opts }
    elseif opts == nil then
      opts = dopts
    else
      for k, v in pairs(opts) do
        dopts[k] = v
      end
      opts = dopts
    end
    -- opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("i", "jj", "<esc><esc>", "esc to normal mode")
-- map("n", "ZZ", vim.cmd.qall, "close all files and quit vim")

