-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = "*.css",
--   callback = function()
--     vim.bo.filetype = "tailwindcss"
--   end,
-- })
--

vim.api.nvim_create_autocmd(
  { "FocusLost", "ModeChanged", "TextChanged", "BufEnter" },
  { desc = "autosave", pattern = "*", command = "silent! update" }
)

-- Remove the default <CR> mapping from mini.pairs
require("mini.pairs").unmap("i", "<CR>", "")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dotenv",
  callback = function()
    vim.bo.syntax = "sh"
  end,
})
