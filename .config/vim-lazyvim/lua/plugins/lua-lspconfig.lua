-- lua/plugins/lsp-lua.lua
return {
    "neovim/nvim-lspconfig",
  -- no event here; let LazyVim control load order
  opts = function(_, opts)
    opts = opts or {}
    opts.servers = opts.servers or {}
    opts.servers.lua_ls = {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
        },
      },
    }
    return opts
  end,
}
