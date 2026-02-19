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

vim.lsp.config.ltex = {
  settings = {
    ltex = {
      language = "fr",
    },
  },
  checkFrequency = "save",
}

vim.lsp.enable(servers)
