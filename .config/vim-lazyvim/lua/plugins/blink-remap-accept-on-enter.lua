-- -- ~/.config/nvim/lua/plugins/blink-cmp.lua
-- return {
--   {
--     "saghen/blink.cmp",
--     -- make sure we load early enough
--     event = "InsertEnter",
--     opts = function(_, opts)
--       -- override just the two keys you care about:
--       opts.keymap = vim.tbl_extend("force", opts.keymap or {}, {
--         -- CR cancels/fallbacks (i.e. just newline)
--         ["<CR>"] = { "cancel", "fallback" },
--         -- C-y selects & accepts
--         ["<C-y>"] = { "select_and_accept" },
--       })
--     end,
--   },
-- }

-- return {
--   {
--     "saghen/blink.cmp",
--     event = "InsertEnter",
--     opts = function(_, opts)
--       opts.keymap = vim.tbl_extend("force", opts.keymap or {}, {
--         -- CR: cancel the popup, then fall back _to_ Vim’s CR (newline)
--         ["<CR>"] = { "cancel", "fallback_to_mappings" },
--         -- Ctrl-Y: select & accept
--         ["<C-y>"] = { "select_and_accept" },
--       })
--     end,
--   },
-- }
-- ~/.config/nvim/lua/plugins/blink-cmp.lua

-- disable accept suggestion on <CR>
return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    opts = function(_, opts)
      -- take the existing keymap table, and force-replace just these two entries:
      opts.keymap = vim.tbl_extend("force", opts.keymap or {}, {
        -- “eat” any Blink mapping for <CR> by giving it an empty list;
        -- apply.keymap_to_current_buffer will skip mapping commands == {}
        ["<CR>"] = {},

        -- keep Ctrl-Y as your only “accept” key
        ["<C-y>"] = { "select_and_accept" },
        ["<tab>"] = { "select_and_accept" },
      })
    end,
  },
}
