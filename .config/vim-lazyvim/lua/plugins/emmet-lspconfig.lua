return {
  -- Ensure the server is installed (Mason)
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "emmet_language_server") then
        table.insert(opts.ensure_installed, "emmet_language_server")
      end
      return opts
    end,
  },

  -- Configure the server (nvim-lspconfig)
  -- Lazy spec that configures Emmet LSP via lspconfig through LazyVim's "servers" table.
  -- IMPORTANT: Do NOT put any bare `lspconfig.emmet_language_server.setup(...)` below this return.
  {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          emmet_language_server = {
            filetypes = {
              "css",
              "eruby",
              -- "html",
              "javascript",
              "javascriptreact",
              "less",
              "sass",
              "scss",
              "pug",
              "typescriptreact",
              -- Phoenix templates:
              "heex",
              -- "eelixir",
              "elixir",
              -- "leex",
            },
            init_options = {
              includeLanguages = {
                -- heex = "html",
                -- eelixir = "html",
                -- elixir = "html",
                -- leex = "html",
              },
              excludeLanguages = {},
              extensionsPath = {},
              preferences = {},
              showAbbreviationSuggestions = true,
              showExpandedAbbreviation = "always",
              showSuggestionsAsSnippets = false,
              syntaxProfiles = {},
              variables = {},
            },
          },
        },
      },
    },
  },
}
