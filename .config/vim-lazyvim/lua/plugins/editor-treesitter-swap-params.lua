-- ~/.config/nvim-LazyVim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  opts = function(_, opts)
    opts.textobjects = opts.textobjects or {}

    opts.textobjects.swap = vim.tbl_deep_extend("force", opts.textobjects.swap or {}, {
      enable = true,
      swap_next = { ["]x"] = "@parameter.inner" },
      swap_previous = { ["[x"] = "@parameter.inner" },
    })
  end,
}
