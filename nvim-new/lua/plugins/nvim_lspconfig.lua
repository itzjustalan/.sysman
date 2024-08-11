return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      setup = {
        biome = function()
          require("lspconfig").biome.setup{}
          return true
        end,
      }
    },
  },
}
