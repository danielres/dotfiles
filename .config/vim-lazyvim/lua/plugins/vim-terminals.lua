return {
  {
    "LazyVim/LazyVim",
    keys = {
      -- terminal in the current window (new terminal buffer)
      {
        "<leader>to",
        function()
          vim.cmd("terminal")
        end,
        desc = "Terminal (here)",
      },

      -- terminal in a horizontal split
      {
        "<leader>ts",
        function()
          vim.cmd("split | terminal")
        end,
        desc = "Terminal (split)",
      },

      -- terminal in a vertical split
      {
        "<leader>tv",
        function()
          vim.cmd("vsplit | terminal")
        end,
        desc = "Terminal (vsplit)",
      },

      -- terminal in a new tab
      {
        "<leader>tt",
        function()
          vim.cmd("tabnew | terminal")
        end,
        desc = "Terminal (tab)",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
          vim.cmd("startinsert") -- enter insert mode
          vim.bo.buflisted = true -- list terminal buffers
          vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = true, silent = true })
          vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { buffer = true, silent = true })
          vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { buffer = true, silent = true })
          vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { buffer = true, silent = true })
          vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { buffer = true, silent = true })
        end,
      })
    end,
  },
}
