return {
  -- Ensure the Biome binary is installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "biome" })
      return opts
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "biome" })
      return opts
    end,
  },

  -- LSP config: start Biome only in projects that have a biome config
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local util = require("lspconfig.util")
      opts = opts or {}
      opts.servers = opts.servers or {}
      opts.setup = opts.setup or {}

      -- Biome LSP
      opts.servers.biome = {
        cmd = { "biome", "lsp-proxy" },
        root_dir = util.root_pattern("biome.json", "biome.jsonc"),
        single_file_support = false,
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "json",
          "jsonc",
        },
      }

      -- Prefer Biome for format/lint; disable formatting in TS LSPs to avoid conflicts
      local function disable_fmt(server)
        local prev = opts.setup[server]
        opts.setup[server] = function(_, conf)
          local on_attach = conf.on_attach
          conf.on_attach = function(client, bufnr)
            if on_attach then
              on_attach(client, bufnr)
            end
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
          if prev then
            return prev(_, conf)
          end
        end
        opts.servers[server] = vim.tbl_deep_extend("force", opts.servers[server] or {}, {
          settings = {
            typescript = { format = { enable = false } },
            javascript = { format = { enable = false } },
          },
        })
      end

      disable_fmt("vtsls")
      disable_fmt("tsserver")

      return opts
    end,
  },
}
