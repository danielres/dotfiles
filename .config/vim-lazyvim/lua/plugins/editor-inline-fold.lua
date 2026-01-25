return {
  "razak17/tailwind-fold.nvim",
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade", "heex" },

  keys = {
    {
      "<space>ut",
      "<cmd>TailwindFoldToggle<CR>",
      mode = "n",
      desc = "Tailwind fold: toggle",
      buffer = true,
      silent = true,
    },
  },
}
