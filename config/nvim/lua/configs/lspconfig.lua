require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "emmet_ls",
  "clangd",
  "bashls",
  "lua_ls",
  "pyright",
  "rust_analyzer",
  "marksman",
  "jsonls",
  "yamlls",
  "taplo",
  "texlab",
  "ltex",
  "nil_ls",
}

vim.lsp.enable(servers)
