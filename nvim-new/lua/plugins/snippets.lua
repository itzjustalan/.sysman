return {
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").filetype_extend("typescript", { "javascript" })
      require("luasnip").filetype_extend("html", { "javascript" })
      -- require("luasnip.loaders.from_vscode").lazy_load({
      --   paths = { "~/.config/VSCodium/User/snippets" },
      -- })
      -- require("luasnip/util/inspect_snippet").inspect_from_vscode("~/.config/VSCodium/User/snippets/snips.code-snippets")
      -- require("luasnip.util.functions").inspect_snippet("~/.config/VSCodium/User/snippets/javascript.json")
      -- local si = require("luasnip.util.functions.inspect_from_vscode")
      -- si("~/.config/VSCodium/User/snippets/javascript.json")
    end,
  },
}
