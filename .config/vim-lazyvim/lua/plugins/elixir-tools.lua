return {
  "elixir-tools/elixir-tools.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local elixir = require("elixir")
    local elixirls = require("elixir.elixirls")

    elixir.setup({
      nextls = { enable = false },
      elixirls = {
        enable = true,
        -- cmd = vim.fn.exepath("elixir-ls"),
        -- cmd = "/nix/store/cqfb457cph3vjsg9hcdajrfcmg2ds7yg-elixir-ls-0.29.3/bin/elixir-ls",
        -- cmd = "$HOME/.local/share/vim-lazyvim/mason/bin/elixir-ls",
        cmd = "mix format",

        settings = elixirls.settings({
          dialyzerEnabled = fase,
          enableTestLenses = false,
          suggestSpecs = false,
        }),
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<space>cfp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("n", "<space>ctp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("v", "<space>cem", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
        end,
      },
      projectionist = {
        enable = true,
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "tpope/vim-projectionist",
  },
}
