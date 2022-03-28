local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end

require("my.configs.lsp.organise-imports")
require 'my.configs.lsp.lsp-installer'
require('my.configs.lsp.handlers').setup()
require 'my.configs.lsp.null-ls'
