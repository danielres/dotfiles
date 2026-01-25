-- lua/plugins/formatting.lua
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "ProfileFormat" },
  opts = {
    formatters_by_ft = {
      -- elixir = { "mix" },
      -- heex = { "mix" },
      -- eelixir = { "mix" },
      -- surface = { "mix" },

      javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
      json = { "biome" },
      css = { "biome" },
      html = { "biome" },
      svelte = { "biome" },
      vue = { "biome" },
    },
    -- format_on_save = { timeout_ms = 800, lsp_fallback = false },
    default_format_opts = {
      -- async = true,
      -- ltime = 0,
      -- lsp_format = "never",
    },
  },
}
