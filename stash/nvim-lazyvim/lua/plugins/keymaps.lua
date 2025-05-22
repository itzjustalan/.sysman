-- local Util = require("lazyvim.util")

-- local function map(mode, lhs, rhs, opts)
--   local keys = require("lazy.core.handler").handlers.keys
--   ---@cast keys LazyKeysHandler
--   -- do not create the keymap if a lazy keys handler exists
--   if not keys.active[keys.parse({ lhs, mode = mode }).id] then
--     opts = opts or {}
--     opts.silent = opts.silent ~= false
--     if opts.remap and not vim.g.vscode then
--       opts.remap = nil
--     end
--     vim.keymap.set(mode, lhs, rhs, opts)
--   end
-- end

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

local function get_neo_tree_root()
  return function()
    local util = require("lazyvim.util")
    local command = require("neo-tree.command")
    command.execute({ toggle = true, dir = util.get_root() })
  end
end

map("i", "jj", "<esc>", "esc to normal mode")

-- package specifics
map("n", "<leader>o", get_neo_tree_root(), "open file tree")
-- map("n", "<leader>o", ":Neotree toggle<cr>", "open file tree")

return {}
