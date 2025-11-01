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
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

require("conform").setup(options)
