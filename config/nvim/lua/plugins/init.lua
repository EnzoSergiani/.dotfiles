return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
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
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {},
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
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.cmd [[Lazy load markdown-preview.nvim]]
      vim.fn['mkdp#util#install']()
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
