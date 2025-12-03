return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      -- Install parsers for your development stack
      ensure_installed = {
        -- Core
        "lua", "vim", "vimdoc", "query",
        -- PHP (Symfony)
        "php", "phpdoc",
        -- JavaScript/TypeScript (React)
        "javascript", "typescript", "tsx", "jsdoc",
        -- Web
        "html", "css", "scss",
        -- Data formats
        "json", "yaml", "toml", "xml",
        -- Documentation
        "markdown", "markdown_inline",
        -- Shell & Config
        "bash", "dockerfile",
        -- Database
        "sql",
      },

      -- Auto-install missing parsers when entering buffer
      auto_install = true,

      -- Syntax highlighting
      highlight = {
        enable = true,
        -- Disable for very large files (performance)
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },

      -- Indentation based on treesitter
      indent = { enable = true },

      -- Incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<S-CR>",
          node_decremental = "<BS>",
        },
      },

      -- Text objects
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- Functions
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            -- Classes
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            -- Parameters/arguments
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            -- Comments
            ["aC"] = "@comment.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
      },
    },
  },
}
