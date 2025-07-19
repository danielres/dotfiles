return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      nixd = {
        settings = {
          nixd = {
            formatting = {
              command = { "nixfmt" }, -- optional: use nixfmt or nixpkgs-fmt
            },
            options = {
              enable = true, -- enables option validation and completion
            },
            nixos = {
              enable = true, -- enables NixOS module and option completion
            },
          },
        },
      },
    },
  },
}
