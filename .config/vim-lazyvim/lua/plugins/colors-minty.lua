-- Docs:
-- https://github.com/nvzone/minty/blob/main/doc/minty.txt
--
-- Keyboard usage:
-- <Ctrl> + t : cycle through windows
-- <Tab> or <S-Tab> : cycle through clickables in current window
-- <CR> i.e enter to click on the area
-- moving cursor with h or l in slider

return {
  "nvzone/minty",
  dependencies = { "nvzone/volt" },
  cmd = { "Shades", "Huefy" },
  opts = {
    huefy = {
      border = false,
      mappings = function(bufs) -- bufs is a table cuz 2 bufs!
        -- add your mappings here ( buffer scoped )

        local api = require("minty.huefy.api")
        vim.keymap.set("n", "s", api.save_color, { buffer = buf })
      end,
      -- func must return { row, col }
      position = "cursor", -- cursor | center | func(w, h)
    },

    shades = {
      border = true,
      mappings = function(buf)
        -- add your mappings here ( buffer scoped )
        local api = require("minty.shades.api")
        vim.keymap.set("n", "s", api.save_color, { buffer = buf })
      end,
      -- func must return { row, col }
      position = "cursor", -- cursor | center | func(w, h)
    },
  },
  keys = {
    { "<leader>cs", "<cmd>Shades<CR>", desc = "Minty Shades" },
    { "<leader>ch", "<cmd>Huefy<CR>", desc = "Minty Huefy" },
  },
}

-- return {
--   "uga-rosa/ccc.nvim",
--   opts = function()
--     local input = require("ccc.input")
--     local output = require("ccc.output")
--     return {
--       highlighter = { auto_enable = true },
--       inputs = { input.hex, input.hex_alpha, input.css_rgb, input.css_hsl },
--       outputs = { output.hex, output.hex_alpha, output.css_rgb, output.css_hsl },
--       -- (optional) also highlight/recognize Hypr rgba(RRGGBBAA)
--       highlighter = {
--         auto_enable = true,
--         custom_pattern = { "rgba%(%x%x%x%x%x%x%x%x%)" },
--       },
--     }
--   end,
--   keys = {
--     { "<leader>cp", "<cmd>CccPick<CR>", desc = "Color Pick (under cursor)" },
--     { "<leader>cc", "<cmd>CccConvert<CR>", desc = "Convert Color Format" },
--   },
-- }
