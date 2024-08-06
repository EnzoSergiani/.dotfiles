return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("configs.conform")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				-- LSP
				"bash-language-server",
				"clangd",
				"css-lsp",
				"eslint-lsp",
				"html-lsp",
				"lua-language-server",
				"marksman",
				"pyright",
				"texlab",
				"typescript-language-server",
				-- Formatter
				"asmfmt",
				"black",
				"clang-format",
				"latexindent",
				"markdown-toc",
				"prettier",
				"shfmt",
				"stylua",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"asm",
				"bash",
				"c",
				"cpp",
				"python",
				"markdown",
				"latex",
			},
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		lazy = false,
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		opts = {
			{
				keywords = {
					FIX = {
						icon = " ",
						color = "error",
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
					},
					TODO = {
						icon = " ",
						color = "info",
					},
					HACK = {
						icon = "󰻌 ",
						color = "warning",
					},
					WARN = {
						icon = " ",
						color = "warning",
						alt = { "WARNING", "WARN" },
					},
					PERF = {
						icon = " ",
						alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
					},
					NOTE = {
						icon = " ",
						color = "hint",
						alt = { "INFO" },
					},
					TEST = {
						icon = " ",
						color = "test",
						alt = { "TESTING", "PASSED", "FAILED" },
					},
				},
			},
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {},
	},
	{
		"tpope/vim-fugitive",
		lazy = false,
		event = "VeryLazy",
		config = function() end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			workspaces = {
				{
					name = "ISEN",
					path = "~/Documents/ISEN",
				},
				{
					name = "Notes",
					path = "~/Documents/Notes",
				},
			},
			ui = {
				enable = true,
			},
		},
	},
}
