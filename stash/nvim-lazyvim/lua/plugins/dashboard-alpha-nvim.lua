return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
             /|
             \\  \`.
        ,'/  ||   ) `.
      ,' (   //,-'_,-'    ,
.    `-._`-.  |  (_____,-'/
\`-._____)  | | ,-'-.    /
 \    ,-'-. | |/     ) ,'
  `. (     \|     _,','
    `.`._
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    return dashboard
  end,
}
