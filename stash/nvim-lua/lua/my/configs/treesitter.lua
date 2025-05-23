local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {
    "go",
    "lua",
    "javascript",
    "typescript",
  },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  auto_install = true,
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "latex" }, -- list of language that will be disabled
    -- additional_vim_regex_highlighting = true,
    -- additional_vim_regex_highlighting = false,
    additional_vim_regex_highlighting = {
      "js",
      "ts"
    },
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
 rainbow = {
   enable = true,
   -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
   extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
   max_file_lines = 2000, -- Do not enable for files with more than n lines, int
   -- colors = {}, -- table of hex strings
   -- termcolors = {} -- table of colour name strings
 }
}
