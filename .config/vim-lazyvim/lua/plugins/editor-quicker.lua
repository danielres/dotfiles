return {
  "stevearc/quicker.nvim",
  ft = "qf",
  opts = {
    edit = {
      enabled = true,
      autosave = "unmodified",
    },
  },
  config = function(_, opts)
    require("quicker").setup(opts)
    -- Override save_changes to add debugging
    local save_changes = require("quicker.editor").save_changes
    require("quicker.editor").save_changes = function(bufnr, loclist_win)
      print("save_changes called, modified:", vim.bo[bufnr].modified)
      save_changes(bufnr, loclist_win)
    end
  end,
}
