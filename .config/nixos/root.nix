# root.nix

{ ... }: {
  # drop the non‑existent option
  # users.users.root.shellInit = ...   # ← remove this line

  # add a small profile‑d script executed for every shell;
  # it exports the variable only when the effective UID is 0 (root).
  environment.etc."profile.d/99-root-nvim.sh".text = ''
    [ "$EUID" -eq 0 ] && export NVIM_APPNAME=vim-lazyvim
  '';
}

