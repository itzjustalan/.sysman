return {
  "ThePrimeagen/harpoon",
  keys = {
    {
      "<leader>h",
      function()
        require("harpoon"):list():append()
      end,
      desc = "Harpoon file",
    },
    {
      "<leader>H",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon quick menu",
    },
  },
}
