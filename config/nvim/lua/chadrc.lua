-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme_toggle = { "onedark", "one_light" },
  theme = "onedark",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazylodd = false,
  },
  statusline = {
    theme = "vscode_colored",
  },
}

M.mason = {
  cmd = true,
  pkgs = {
    -- lua
    "lua-language-server",
    "stylua",
    -- bash
    "bash-language-server",
    "shfmt",
    -- c/c++
    "clangd",
    "clang-format",
    -- python
    "pyright",
    "ruff",
    "black",
    "debugpy",
    -- rust
    "rust-analyzer",
    "rustfmt",
    -- markdown
    "marksman",
    -- latex
    "texlab",
    "latexindent",
    "ltex-ls",
    "vale",
    -- yaml/json
    "yaml-language-server",
    "json-lsp",
    -- toml
    "taplo",
    -- html/css
    "html-lsp",
    "css-lsp",
    "emmet-ls",
    -- javascript/typescriptreact
    "typescript-language-server",
    "prettier",
    "eslint_d",
    -- nix
    "rnix-lsp",
    "nixpkgs-fmt",
  },
}

return M
