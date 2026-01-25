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

-- vim.api.nvim_create_autocmd("FileType", {
--   group = vim.api.nvim_create_augroup("GitBufhiddenDelete", { clear = true }),
--   pattern = { "gitcommit", "gitrebase", "gitconfig" },
--   callback = function()
--     vim.opt_local.bufhidden = "delete"
--   end,
-- })

-- Lazygit: keep session, avoid eating "q" while typing commit messages
-- -- Restore lazygit session - see https://github.com/LazyVim/LazyVim/discussions/4681#discussioncomment-11134276
-- vim.api.nvim_create_autocmd("TermOpen", {
--   pattern = "*",
--   callback = function()
--     local term_title = vim.b.term_title
--     if term_title and term_title:match("lazygit") then
--       -- Create lazygit specific mappings
--       vim.keymap.set("t", "q", "<cmd>close<cr>", { buffer = true })
--     end
--   end,
-- })
--
-- Auto-load last session if starting without file args (skips dashboard)
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim.fn.argc() == 0 then
      -- ensure the plugin is actually loaded before using it
      local ok_lazy, lazy = pcall(require, "lazy")
      if ok_lazy then
        pcall(lazy.load, { plugins = { "persistence.nvim" } })
      end
      local ok, persistence = pcall(require, "persistence")
      if ok then
        persistence.load({ last = true })
      end
    end
  end,
})

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.hl", ".conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start({
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})

-- keep your autosave as-is
vim.api.nvim_create_autocmd(
  -- { "FocusLost", "ModeChanged", "TextChanged", "BufEnter" },
  { "BufLeave", "FocusLost", "ModeChanged" },
  { desc = "autosave", pattern = "*", command = "silent! update" }
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dotenv",
  callback = function()
    vim.bo.syntax = "sh"
  end,
})

-- disable comment continuation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- disable auto-continue comments when pressing o or O
    vim.opt.formatoptions:remove("o")
    -- disable auto-continue comments when pressing <Enter>
    -- vim.opt.formatoptions:remove("r")
  end,
})
