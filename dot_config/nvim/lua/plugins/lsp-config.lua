return {
  -- Schema store for JSON LSP
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/schemastore.nvim" },
    opts = function()
      return {
        -- Diagnostics configuration
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          severity_sort = true,
        },
        -- Inlay hints configuration
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes to exclude
        },
        -- Code folding configuration
        folds = {
          enabled = false, -- Use treesitter for folding instead
        },
        -- Code lens configuration
        codelens = {
          enabled = true,
        },
        -- Format configuration
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- Custom server setup handlers
        setup = {
          -- Default handler for all servers (can be overridden per server)
          -- ["*"] = function(server, opts) end,
        },
        -- LSP Server Settings
        servers = {
        -- Default capabilities for all servers
        ["*"] = {
          capabilities = {
            workspace = {
              fileOperations = {
                didRename = true,
                willRename = true,
              },
            },
          },
        },
        -- PHP
        phpactor = {
          enabled = true,
          filetypes = { "php" },
        },
        intelephense = {
          enabled = false, -- Disable if using phpactor
          filetypes = { "php" },
          settings = {
            intelephense = {
              files = {
                maxSize = 1000000,
              },
            },
          },
        },

        -- JavaScript/TypeScript
        -- Migrated from deprecated 'tsserver' to 'ts_ls'
        ts_ls = {
          enabled = true,
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },

        -- HTML/CSS
        html = {
          enabled = true,
          filetypes = { "html" },
        },
        cssls = {
          enabled = true,
          filetypes = { "css", "scss", "less" },
        },

        -- JSON
        jsonls = {
          enabled = true,
          filetypes = { "json", "jsonc" },
          on_new_config = function(new_config)
            local ok, schemastore = pcall(require, "schemastore")
            if ok then
              new_config.settings.json.schemas = new_config.settings.json.schemas or {}
              vim.list_extend(new_config.settings.json.schemas, schemastore.json.schemas())
            end
          end,
          settings = {
            json = {
              schemas = {},
              validate = { enable = true },
            },
          },
        },

        -- Lua
        lua_ls = {
          enabled = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        },
      }
    end,
  },
}