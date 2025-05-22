local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
  return
end

-- your personnal icons can go here (to override)
-- you can specify color or cterm_color instead of specifying both of them
-- DevIcon will be appended to `name`

local opts = {
  override = {
    ["zsh"] = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    },
    ["Makefile"] = {
      icon = "",
      color = "#f58c14",
      cterm_color = "67",
      name = "Makefile",
    },
    md = {
      icon = "",
      color = "#f58c14",
      cterm_color = "65",
      name = "Md"
    },
    Dockerfile = {
      icon = "",
      color = "#519aba",
      cterm_color = "67",
      name = "Dockerfile",
    },
    ["go.mod"] = {
      icon = "",
      color = "#519aba",
      cterm_color = "67",
      name = "Gomod",
    },
    ["go.sum"] = {
      icon = "",
      color = "#519aba",
      cterm_color = "67",
      name = "Gosum",
    },
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

nvim_web_devicons.setup(opts)
