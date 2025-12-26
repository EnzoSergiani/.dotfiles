local options = {
  formatters_by_ft = {
    -- lua
    lua = { "stylua" },
    -- bash
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    -- c/c++
    c = { "clang_format" },
    cpp = { "clang_format" },
    -- python
    python = { "black" },
    -- rust
    rust = { "rustfmt" },
    -- markdown
    markdown = { "prettier" },
    -- latex
    tex = { "latexindent" },
    bib = { "bibtex-tidy" },
    -- yaml/json/jsonc
    yaml = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    -- toml
    toml = { "taplo" },
    -- html/css
    html = { "prettier" },
    css = { "prettier" },
    -- javascript/typescript
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    -- nix
    nix = { "nixpkgs_fmt" },
    -- Universal Formats
    ["*"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" },
  },

  formatters = {
    latexindent = {
      command = "latexindent",
      args = { "-c=build", "-g=build/indent.log", "-" },
    },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
return options
