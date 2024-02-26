local overrides = require "custom.configs.overrides"
local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = { -- override plugin configs
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { -- lua
        "lua-language-server",
        "stylua",       -- web
        "html-lsp",
        "css-lsp",
        "prettier", -- c/c++
        "clangd",
        "clang-format",
        "codelldb", -- python
        "pyright",
        "black",
        "debugpy",      -- node.js
        "typescript-language-server",
        "js-debug-adapter", -- markdown
        "deno",
        "markdown-toc", -- latex
        "latexindent",  -- git
        "gitui",
      },
    },
  }, -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,           -- Override to setup mason-lspconfig
    dependencies = { -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        config = function()
          require("custom.configs.null-ls")
        end,
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
        "json",
        "c",
        "cpp",
        "python",
        "latex",
        "markdown",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  }, -- Markdown:
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    lazy = false,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      -- set to 1, the nvim will auto close current preview window when change
      -- from markdown buffer to another buffer
      -- default: 1
      vim.g.mkdp_auto_close = 0

      -- use custom IP to open preview page
      -- useful when you work in remote vim and preview on local browser
      -- more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
      -- default empty
      vim.g.mkdp_open_ip = ""

      -- use a custom markdown style must be absolute path
      -- like '/Users/username/markdown.css' or expand('~/markdown.css')
      vim.g.mkdp_markdown_css = "/home/enzo/.config/nvim/lua/custom/style/markdown.css"

      -- use a custom highlight style must absolute path
      -- like '/Users/username/highlight.css' or expand('~/highlight.css')
      vim.g.mkdp_highlight_css = ""

      -- use a custom port to start server or empty for random
      vim.g.mkdp_port = "1111"

      -- use a custom location for images
      -- vim.g.mkdp_images_path = /home/user/.markdown_images

      -- preview page title
      -- ${name} will be replace with the file name
      vim.g.mkdp_page_title = "「${name}」"

      -- set default theme (dark or light)
      -- By default the theme is define according to the preferences of the system
      vim.g.mkdp_theme = "light"

      -- options for markdown render
      -- mkit: markdown-it options for render
      -- katex: katex options for math
      -- uml: markdown-it-plantuml options
      -- maid: mermaid options
      -- disable_sync_scroll: if disable sync scroll, default 0
      -- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
      --   middle: mean the cursor position alway show at the middle of the preview page
      --   top: mean the vim top viewport alway show at the top of the preview page
      --   relative: mean the cursor position alway show at the relative positon of the preview page
      -- hide_yaml_meta: if hide yaml metadata, default is 1
      -- sequence_diagrams: js-sequence-diagrams options
      -- content_editable: if enable content editable for preview page, default: v:false
      -- disable_filename: if disable filename header for preview page, default: 0
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 1,
        toc = {},
      }
    end,
  }, -- LaTex
  {
    "lervag/vimtex",
    lazy = false,
  }, -- Debugger
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      handlers = {},
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- ? Ferme automatiquement le debugger
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
  },
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    opts = {
      {
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          -- height and width can be:
          -- * an absolute number of cells when > 1
          -- * a percentage of the width / height of the editor when <= 1
          -- * a function that returns the width or the height
          width = 120, -- width of the Zen window
          height = 1, -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
            -- you may turn on/off statusline in zen mode by setting 'laststatus'
            -- statusline will be shown only if 'laststatus' == 3
            laststatus = 0, -- turn off the statusline in zen mode
          },
          twilight = {
            enabled = true,
          }, -- enable to start Twilight when zen mode opens
          gitsigns = {
            enabled = false,
          }, -- disables git signs
          tmux = {
            enabled = false,
          }, -- disables the tmux statusline
          -- this will change the font size on kitty when in zen mode
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = false,
            font = "+4", -- font size increment
          },

          -- this will change the font size on alacritty when in zen mode
          -- requires  Alacritty Version 0.10.0 or higher
          -- uses `alacritty msg` subcommand to change font size
          alacritty = {
            enabled = false,
            font = "14", -- font size
          },
          -- this will change the font size on wezterm when in zen mode
          -- See alse also the Plugins/Wezterm section in this projects README
          wezterm = {
            enabled = false,
            -- can be either an absolute font size or the number of incremental steps
            font = "+4", -- (10% increase per step)
          },
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function(win) end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function() end,
      },
    },
  }, -- [
  {
    "segeljakt/vim-silicon",
    event = "VeryLazy",
    config = function()
      vim.g.silicon = {
        -- theme = "Dracula",
        -- font = "Hack",
        background = "#295844",
        -- shadow_color = "#555555",
        -- line_pad = 2,
        -- pad_horiz = 80,
        -- pad_vert = 100,
        -- shadow_blur_radius = 0,
        -- shadow_offset_x = 0,
        -- shadow_offset_y = 0,
        -- line_number = v:true,
        -- round_corner = v:true,
        -- window_controls = v:true,
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    lazy = true,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
      {
        signs = true,  -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
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
            alt = { "WARNING", "XXX", "WARN" },
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
            icon = "⏲ ",
            color = "test",
            alt = { "TESTING", "PASSED", "FAILED" },
          },
          QUESTION = {
            icon = " ",
            color = "question",
            alt = { "?", "??", "???" },
          },
        },
        gui_style = {
          fg = "NONE",     -- The gui style to use for the fg highlight group.
          bg = "BOLD",     -- The gui style to use for the bg highlight group.
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          multiline = true,           -- enable multine todo comments
          multiline_pattern = "^.",   -- lua pattern to match the next multiline from the start of the matched keyword
          multiline_context = 10,     -- extra lines that will be re-evaluated when changing a line
          before = "",                -- "fg" or "bg" or empty
          keyword = "wide",           -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
          after = "fg",               -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
          comments_only = true,       -- uses treesitter to match keywords in comments only
          max_line_len = 400,         -- ignore lines longer than this
          exclude = {},               -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of highlight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
          question = { "DiagnosticInfo", "#2b00ff" },
        },
        search = {
          command = "rg",
          args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      },
    },
  },
}

return plugins
