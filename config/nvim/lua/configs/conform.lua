local function bin(name)
  local env_path = vim.fn.exepath(name)
  if env_path ~= "" then
    return env_path
  end
  return "/etc/profiles/per-user/dousai/bin/" .. name
end
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
    -- astro
    astro = { "prettier" },
    -- nix
    nix = { "nixpkgs_fmt" },
    -- typst
    typst = { "typstyle" },
    -- Universal Formats
    ["*"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" },
  },
  formatters = {
    stylua = { command = bin "stylua" },
    shfmt = { command = bin "shfmt" },
    black = { command = bin "black" },
    clang_format = { command = bin "clang-format" },
    rustfmt = { command = bin "rustfmt" },
    prettier = { command = bin "prettier" },
    taplo = { command = bin "taplo" },
    nixpkgs_fmt = { command = bin "nixpkgs-fmt" },
    latexindent = {
      command = bin "latexindent",
      args = { "-c=build", "-g=build/indent.log", "-" },
    },
    ["bibtex-tidy"] = {
      command = bin "bibtex-tidy",
      args = { "--modify" },
    },
    typstyle = { command = bin "typstyle" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
return options
