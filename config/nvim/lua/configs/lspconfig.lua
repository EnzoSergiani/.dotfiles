require("nvchad.configs.lspconfig").defaults()

local function bin(name)
  local env_path = vim.fn.exepath(name)
  if env_path ~= "" then
    return env_path
  end
  return "/etc/profiles/per-user/dousai/bin/" .. name
end

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
  "astro",
  "tinymist",
}

vim.lsp.config.ltex = {
  settings = {
    ltex = {
      language = "fr",
    },
  },
  checkFrequency = "save",
}

local tsc_path = bin "tsc"
local tsdk_path = ""
if tsc_path ~= "" then
  local store_root = tsc_path:match "(.*)/bin/tsc$"
  if store_root then
    tsdk_path = store_root .. "/lib/node_modules/typescript/lib"
  end
end

vim.lsp.config.astro = {
  cmd = { bin "astro-ls", "--stdio" },
  init_options = {
    typescript = {
      tsdk = tsdk_path,
    },
  },
}

vim.lsp.config.cssls = {
  filetypes = { "css", "scss", "less", "astro" },
  settings = {
    css = { validate = true },
    scss = { validate = true },
  },
}

vim.lsp.config.tinymist = {
  cmd = { bin "tinymist" },
  settings = {
    exportPdf = "onSave",
    formatterMode = "typstyle", -- aligne le formatage interne du LSP sur typstyle
  },
}

vim.lsp.enable(servers)
