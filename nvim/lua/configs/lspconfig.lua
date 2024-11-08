-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = {
  "html", -- HTML
  "cssls", -- CSS
  "ts_ls", -- JavaScript and TypeScript
  "bashls", -- Bash
  "clangd", -- C and C++
  "pyright", -- Python
  "texlab", -- LaTeX
  "marksman", -- Markdown
  "lua_ls", -- Lua
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end
