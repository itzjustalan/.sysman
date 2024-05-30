return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    {
      "<leader>o",
      function()
        local Util = require("lazyvim.util")
        require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        -- visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".git",
          "node_modules"
        },
      }
    },
    window = {
      mappings = {
        ["l"] = "open",
        ["e"] = function()
          vim.api.nvim_exec("Neotree focus filesystem left", true)
        end,
        ["b"] = function()
          vim.api.nvim_exec("Neotree focus buffers left", true)
        end,
        ["c"] = function()
          vim.api.nvim_exec("Neotree focus git_status left", true)
        end,
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function(_)
          vim.cmd([[Neotree close]])
        end,
      },
    },
  },
}

