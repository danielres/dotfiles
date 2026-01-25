-- defaults:
-- https://github.com/obsidian-nvim/obsidian.nvim/blob/7a1a205d81841876b763c4d3fff08836e51d508d/lua/obsidian/config/default.lua

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/vaults/main",
      },
    },
    checkbox = {
      enabled = true,
      create_new = true,
      -- order = { " ", "~", "!", ">", "x" },
      order = { " ", "x" },
    },

    templates = {
      folder = "utils/templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    -- see below for full list of options 👇
  },
  keys = {
    {
      "<space>oo",
      "<cmd>ObsidianOpen<CR>",
      mode = "n",
      desc = "Open Obsidian",
      silent = true,
    },
    {
      "<space>og",
      "<cmd>ObsidianTags<CR>",
      mode = "n",
      desc = "Tags",
      silent = true,
    },
    {
      "<space>o<space>",
      "<cmd>ObsidianQuickSwitch<CR>",
      mode = "n",
      desc = "Quick switch",
      silent = true,
    },
    {
      "<space>os",
      "<cmd>ObsidianSearch<CR>",
      mode = "n",
      desc = "Search",
      silent = true,
    },
    {
      "<space>ott",
      "<cmd>ObsidianTemplate<CR>",
      mode = "n",
      desc = "Apply template",
      silent = true,
    },
    {
      "<space>otn",
      "<cmd>ObsidianNewFromTemplate<CR>",
      mode = "n",
      desc = "New from template",
      silent = true,
    },
    {
      "<C-S-space>",
      "<cmd>ObsidianToggleCheckbox<CR>",
      mode = { "n", "i", "v" },
      desc = "Toggle checkbox",
      silent = true,
    },
  },
}

-- -- docs:
-- -- https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#commands
--
-- return {
--   "obsidian-nvim/obsidian.nvim",
--   version = "*", -- recommended, use latest release instead of latest commit
--   lazy = true,
--   ft = "markdown",
--   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
--   -- event = {
--   --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
--   --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
--   --   -- refer to `:h file-pattern` for more examples
--   --   "BufReadPre path/to/my-vault/*.md",
--   --   "BufNewFile path/to/my-vault/*.md",
--   -- },
--   dependencies = {
--     -- Required.
--     "nvim-lua/plenary.nvim",
--
--     -- see below for full list of optional dependencies 👇
--   },
--
--   opts = {
--     workspaces = {
--       {
--         name = "personal",
--         path = "~/Documents/vaults/main",
--       },
--     },
--
--     templates = {
--       folder = "utils/templates",
--       date_format = "%Y-%m-%d",
--       time_format = "%H:%M",
--     },
--   },
--
--   keys = {
--     {
--       "<space>oo",
--       "<cmd>ObsidianOpen<CR>",
--       mode = "n",
--       desc = "Open Obsidian",
--       silent = true,
--     },
--     {
--       "<space>og",
--       "<cmd>ObsidianTags<CR>",
--       mode = "n",
--       desc = "Tags",
--       silent = true,
--     },
--     {
--       "<space>o<space>",
--       "<cmd>ObsidianQuickSwitch<CR>",
--       mode = "n",
--       desc = "Quick switch",
--       silent = true,
--     },
--     {
--       "<space>os",
--       "<cmd>ObsidianSearch<CR>",
--       mode = "n",
--       desc = "Search",
--       silent = true,
--     },
--     {
--       "<space>ott",
--       "<cmd>ObsidianTemplate<CR>",
--       mode = "n",
--       desc = "Apply template",
--       silent = true,
--     },
--     {
--       "<space>otn",
--       "<cmd>ObsidianNewFromTemplate<CR>",
--       mode = "n",
--       desc = "New from template",
--       silent = true,
--     },
--   },
-- }
