return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "elixir", "heex", "eex", "surface" },
    highlight = { enable = true, additional_vim_regex_highlighting = false },
  },
}
