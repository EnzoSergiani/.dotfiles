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

  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_filetypes = {
        ["*"] = true,
      }
    end
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
  {
    "lervag/vimtex",
    ft = { "tex" },
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        aux_dir = "build",
        out_dir = "build",
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-shell-escape",
          "-pdf",
        },
      }
      vim.g.vimtex_view_general_viewer = "zathura"
      vim.g.vimtex_view_general_options = "--synctex-forward @line:@col:@tex @pdf"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_complete_enabled = 1
      vim.g.vimtex_quickfix_ignore_filters = {
        'Underfull',
        'Overfull',
        'Package hyperref Warning',
      }
      vim.g.vimtex_syntax_custom_cmds = {
        {
          name = 'mintinline',
          mathmode = 0,
          concealchar = '',
        },
      }
    end,
    keys = {
      { "<localleader>ll", "<cmd>VimtexCompile<cr>", desc = "VimTex Compile (continuous)" },
      { "<localleader>lk", "<cmd>VimtexStop<cr>", desc = "VimTex Stop compilation" },
      { "<localleader>lv", "<cmd>VimtexView<cr>", desc = "VimTex View PDF (report.pdf)" },
      { "<localleader>lc", "<cmd>VimtexClean<cr>", desc = "VimTex Clean aux files" },
      { "<localleader>lC", "<cmd>VimtexClean!<cr>", desc = "VimTex Clean all" },
      { "<localleader>lt", "<cmd>VimtexTocOpen<cr>", desc = "VimTex TOC" },
      { "<localleader>le", "<cmd>VimtexErrors<cr>", desc = "VimTex Errors" },
      { "<localleader>li", "<cmd>VimtexInfo<cr>", desc = "VimTex Info" },
      { "<localleader>lm", "<cmd>VimtexImapsList<cr>", desc = "VimTex Mappings" },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        tex = { "latexindent" },
      },
      formatters = {
        latexindent = {
          command = "latexindent",
          args = { "-c=build", "-g=build/indent.log", "-" },
        },
      },
    },
  },

}
