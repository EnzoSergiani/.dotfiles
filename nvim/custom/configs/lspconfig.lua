local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- c / cpp
lspconfig.clangd.setup{
  on_attach = function(client, bufnr)
    client.server_capabilites.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities
}

-- pythons
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

-- html / xml
lspconfig.html.setup {
  cmd = { "/usr/bin/html-languageserver", "--stdio" },
  filetypes = { "html", "xml" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = { css = true, javascript = true }
  },
  settings = {}
}

-- css
lspconfig.cssls.setup {
  cmd = { "/usr/bin/css-languageserver", "--stdio" },
  filetypes = { "css", "scss", "less" },
  settings = {}
}


lspconfig.tsserver.setup{
  on_attach = on_attach;
  capabilities = capabilities;
  init_options = {
    preferences = {
      disableSuggestions = true;
    }
  }

}