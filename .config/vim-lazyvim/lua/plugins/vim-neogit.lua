return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
    "nvim-mini/mini.pick",
    "folke/snacks.nvim",
  },

  keys = {
    {
      "<space>gn",
      "<cmd>Neogit<CR>",
      mode = "n",
      desc = "Neogit 🚀",
      buffer = true,
      silent = true,
    },
  },
  -- keys = {
  --   {
  --     "<leader>gn",
  --     function()
  --       require("neogit").open({})
  --     end,
  --     desc = "Neogit",
  --   },
  -- },
  config = function()
    require("neogit").setup({
      signs = {
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
      integrations = { diffview = true },
    })
  end,
}
