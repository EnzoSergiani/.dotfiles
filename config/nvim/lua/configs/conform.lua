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
    stylua = {
      command = "/etc/profiles/per-user/dousai/bin/stylua",
    },
    shfmt = {
      command = "/etc/profiles/per-user/dousai/bin/shfmt",
    },
    black = {
      command = "/etc/profiles/per-user/dousai/bin/black",
    },
    clang_format = {
      command = "/etc/profiles/per-user/dousai/bin/clang-format",
    },
    rustfmt = {
      command = "/etc/profiles/per-user/dousai/bin/rustfmt",
    },
    prettier = {
      command = "/etc/profiles/per-user/dousai/bin/prettier",
    },
    taplo = {
      command = "/etc/profiles/per-user/dousai/bin/taplo",
    },
    nixpkgs_fmt = {
      command = "/etc/profiles/per-user/dousai/bin/nixpkgs-fmt",
    },
    latexindent = {
      command = "/etc/profiles/per-user/dousai/bin/latexindent",
      args = { "-c=build", "-g=build/indent.log", "-" },
    },
    ["bibtex-tidy"] = {
      command = "/etc/profiles/per-user/dousai/bin/bibtex-tidy",
      args = { "--modify" },
    },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
