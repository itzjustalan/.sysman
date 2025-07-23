if true then return {} end

return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <leader>S
      vim.g.db_ui_execute_on_save = false
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = "vim-dadbod",
    ft = sql_ft,
    -- init = function()
    --   vim.api.nvim_create_autocmd("FileType", {
    --     pattern = sql_ft,
    --     callback = function()
    --       local cmp = require("cmp")

    --       -- global sources
    --       ---@param source cmp.SourceConfig
    --       local sources = vim.tbl_map(function(source)
    --         return { name = source.name }
    --       end, cmp.get_config().sources)

    --       -- add vim-dadbod-completion source
    --       table.insert(sources, { name = "vim-dadbod-completion" })

    --       -- update sources for the current buffer
    --       cmp.setup.buffer({ sources = sources })
    --     end,
    --   })
    -- end,
  },
}
