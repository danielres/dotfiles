-- ~/.config/nvim/lua/plugins/hipatterns-hypr.lua
return {
  "nvim-mini/mini.hipatterns",
  opts = function(_, opts)
    local hipatterns = require("mini.hipatterns")
    opts.highlighters = opts.highlighters or {}

    -- keep default #RRGGBB highlighter
    opts.highlighters.hex_color = hipatterns.gen_highlighter.hex_color()

    -- Hyprland rgba(RRGGBBAA) -> strip AA, use #RRGGBB
    opts.highlighters.hypr_rgba_hex = {
      pattern = "rgba%(%x%x%x%x%x%x%x%x%)",
      group = function(_, match)
        local r, g, b = match:match("rgba%((%x%x)(%x%x)(%x%x)%x%x%)")
        if not r then return nil end
        return hipatterns.compute_hex_color_group(string.format("#%s%s%s", r, g, b))
      end,
      priority = 2000,
    }

    -- Hyprland rgb(RRGGBB)
    opts.highlighters.hypr_rgb_hex = {
      pattern = "rgb%(%x%x%x%x%x%x%)",
      group = function(_, match)
        local hex = match:match("rgb%((%x%x%x%x%x%x)%)")
        if not hex then return nil end
        return hipatterns.compute_hex_color_group("#" .. hex)
      end,
      priority = 2000,
    }

    return opts
  end,
}

