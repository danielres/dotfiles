return {
  "synic/refactorex.nvim",
  ft = "elixir",
  ---@module "refactorex.nvim"
  ---@type refactorex.Config
  opts = {
    auto_update = false,
    -- pin_version = "0.1.54",
    pin_version = nil,
  },
  keys = {
    -- pass the function reference (do NOT call it)
    -- { "<space>cr", vim.lsp.buf.rename, mode = "n", desc = "LSP: rename", buffer = true, silent = true },
    { "<space>R", vim.lsp.buf.rename, mode = "n", desc = "LSP: rename", buffer = true, silent = true },
  },
}
