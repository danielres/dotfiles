-- Put this in: lua/plugins/colors.lua (or any LazyVim plugin file)
return {
  { "ellisonleao/gruvbox.nvim", lazy = true },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    init = function()
      vim.opt.termguicolors = true -- required for terminal theming
    end,
    opts = {
      flavour = "mocha",
      term_colors = true, -- applies the 16 terminal colors to :terminal (incl. LazyVim ctrl+/)
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        mason = true,
        mini = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        ["neo-tree"] = true,
        noice = true,
        notify = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
      custom_highlights = function(c)
        return {
          NormalFloat = { bg = c.mantle },
          FloatBorder = { fg = c.surface1, bg = c.mantle },
          FloatTitle = { fg = c.text, bg = c.mantle },
          TermCursor = { reverse = true },
        }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
