local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    tsx = { "prettier" },
    asm = { "asmfmt" },
    bash = { "shfmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    python = { "black" },
    markdown = { "prettier" },
    latex = { "latexindent" },
    tex = { "latexindent" },
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
