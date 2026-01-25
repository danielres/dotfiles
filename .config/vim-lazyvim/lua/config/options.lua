-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.shell = "fish"

-- fix lazyvim lag on fullscreen lazygit
-- vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = "1"
-- vim.env.TERM = "xterm-256color"
vim.g.autoformat = true
---- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { { ".git", "lua" }, "cwd", "lsp" }
-- vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon0"
-- Disable lazyvim's default guicursor and set custom one
-- vim.o.guicursor = ""  -- clear defaults
-- vim.opt.guicursor = {
--   "n-v-c-sm:block-Cursor/lCursor",
--   "i-ci-ve:ver25-Cursor/lCursor",
--   "r-cr-o:hor20-Cursor/lCursor",
--   "a:blinkon0"
-- }

-- lua/config/neovide.lua
if vim.g.neovide then
  vim.o.termguicolors = true

  vim.o.winblend = 0
  vim.o.pumblend = 0
  vim.g.neovide_theme = "dark" -- not "auto" on Wayland
  vim.opt.background = "dark"
  vim.g.neovide_window_blurred = false
  vim.g.neovide_opacity = 0.9
  vim.g.neovide_normal_opacity = 0.9
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.025)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.025)
  end)
end

if vim.g.neovide then
  local function solid_bg()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local bg = normal.bg or 0x1a1b26 -- fallback close to tokyonight
    vim.api.nvim_set_hl(0, "Normal", { bg = bg, fg = normal.fg })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = bg })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = bg })
  end
  vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, { callback = solid_bg })
end
