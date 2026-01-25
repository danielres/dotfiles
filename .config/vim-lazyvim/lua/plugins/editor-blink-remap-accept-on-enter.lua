-- disable accept suggestion on <CR>
return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    opts = function(_, opts)
      -- take the existing keymap table, and force-replace just these two entries:
      opts.keymap = vim.tbl_extend("force", opts.keymap or {}, {
        -- “eat” any Blink mapping for <CR> by giving it an empty list;
        ["<CR>"] = {},

        ["<C-y>"] = { "select_and_accept" },
        ["<Tab>"] = { "select_and_accept" },
      })
    end,
  },
}
