-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true, desc = "Paste without clobbering yank" })


vim.keymap.set("n", "n", "nzzzv", { desc = "Keep search results centered (1/2)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Keep search results centered (2/2)" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor centered when scrolling (1/2)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor centered when scrolling (2/2)" })

vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Make x and s not yank into a register" })

vim.keymap.set("n", "<leader>ba", function()
  Snacks.bufdelete.all()
end, { desc = "Delete All Buffers" })

vim.keymap.set(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor quickly" }
)

vim.keymap.set("n", "gp", function()
  vim.cmd("normal! `[v`]")
end, { desc = "Select last change/paste" })

-- vim.keymap.set("i", "jk", "<Esc>", { desc = "Quickly exit insert mode" })

-- swap J and gJ
vim.keymap.set("n", "J", "gJ", { desc = "Join lines without adding spaces" })
vim.keymap.set("n", "gJ", "J", { desc = "Join lines with space" })

vim.keymap.set(
  "n",
  "<leader>=",
  [[:s/$/\=repeat('=', max([0, 80 - virtcol('$')]))<CR><Esc>]],
  { desc = "Pad = to column 80" }
)

-- Manual “UI reset” key
local function ui_reset()
  vim.cmd([[
    silent! tabdo wincmd =
    redraw!
    redrawstatus!
    nohlsearch
  ]])
end
vim.keymap.set("n", "<leader>ur", ui_reset, { desc = "UI reset (equalize + redraw)" })
