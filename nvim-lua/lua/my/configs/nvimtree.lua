-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- tree bg line color fix
--vim.cmd("autocmd Colorscheme * highlight NvimTreeNormal guibg=#21252B guifg=#9da5b3")

nvim_tree.setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = { "l", "<CR>", "o" }, action = "edit" },
      },
    },
  },
  renderer = {
    group_empty = true,
    indent_markers = {
      enable = true,
    },
  },
  filters = {
    --dotfiles = true,
    custom = {
      ".git",
    },
  },

  -- figureout performance issues
  log = {
    enable = true,
    truncate = true,
    types = {
      git = true,
      profile = true,
    },
  },
})

---- try g? for help
--local treesize = 50;
----vim.g.nvim_tree_icons = {
--local nvim_tree_icons = {
--  default = "",
--  symlink = "",
--  git = {
--    unstaged = "",
--    staged = "S",
--    unmerged = "",
--    renamed = "➜",
--    deleted = "",
--    untracked = "U",
--    ignored = "◌",
--  },
--  folder = {
--    default = "",
--    open = "",
--    empty = "",
--    empty_open = "",
--    symlink = "",
--  },
--}

--nvim_tree.setup {
--  disable_netrw = true,
--  hijack_netrw = true,
--  open_on_setup = false,
--  ignore_ft_on_setup = {
--    "startify",
--    "dashboard",
--    "alpha",
--  },
--  open_on_tab = false,
--  hijack_cursor = false,
--  update_cwd = true,
--  update_to_buf_dir = {
--    enable = true,
--    auto_open = true,
--  },
--  actions = {
--    open_file = {
--      quit_on_open = true,
--      resize_window = true,
--    },
--  },
--  diagnostics = {
--    enable = true,
--    icons = {
--      hint = "",
--      info = "",
--      warning = "",
--      error = "",
--    },
--  },
--  update_focused_file = {
--    enable = true,
--    update_cwd = true,
--    ignore_list = {},
--  },
--  system_open = {
--    cmd = nil,
--    args = {},
--  },
--  filters = {
--    dotfiles = true,
--    custom = {},
--  },
--  git = {
--    enable = true,
--    ignore = true,
--    timeout = 500,
--  },
--  view = {
--    width = treesize,
--    height = treesize,
--    hide_root_folder = false,
--    side = "left",
--    auto_resize = true,
--    mappings = {
--      custom_only = false,
--      list = {
--        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
--        { key = "h", cb = tree_cb "close_node" },
--        { key = "v", cb = tree_cb "vsplit" },
--        { key = "s", cb = tree_cb "split" },
--      },
--    },
--    number = true,
--    relativenumber = true,
--  },
--  trash = {
--    cmd = "trash",
--    require_confirm = true,
--  },
--  quit_on_open = 0,
--  git_hl = 1,
--  disable_window_picker = 0,
--  root_folder_modifier = ":t",
--  show_icons = {
--    git = 1,
--    folders = 1,
--    files = 1,
--    folder_arrows = 1,
--    tree_width = treesize,
--  },
--  renderer = {
--    icons = {
--      glyphs = nvim_tree_icons,
--    },
--  },
--}
