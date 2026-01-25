return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("mcphub").setup({
      cmd = "node",
      cmdArgs = { "/home/daniel/.npm-global/bin/mcp-hub" },
    })
  end,
}
