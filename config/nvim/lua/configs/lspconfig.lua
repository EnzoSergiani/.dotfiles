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
  cmd = { "ltex-ls" },
  filetypes = { "tex", "bib", "markdown" },
  root_markers = { ".git" },
  settings = {
    ltex = {
      language = "fr",
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "fr",
      },
      dictionary = {
        ["fr"] = {},
        ["en"] = {},
      },
      disabledRules = {
        ["fr"] = {},
      },
      enabled = { "latex", "tex", "bib" },
    },
  },
}

vim.lsp.enable(servers)
