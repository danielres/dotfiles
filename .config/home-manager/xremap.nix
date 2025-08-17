# { config, pkgs, lib, ... }:
#
# let
#   xremapYaml = ''
#     default_mode: default
#
#     keymap:
#       - name: layer-switch
#         remap:
#           S:
#             remap:
#               D:
#                 set_mode: nav
#             timeout_millis: 300
#
#       - name: nav-layer
#         mode: nav
#         remap:
#           H:
#             alone: Left
#             held:  Left
#           J:
#             alone: Down
#             held:  Down
#           K:
#             alone: Up
#             held:  Up
#           L:
#             alone: Right
#             held:  Right
#   '';
# in {
#   # write the YAML to ~/.config/xremap.yml
#   home.file.".config/xremap.yml" = { text = xremapYaml; };
#
#   # install the xremap binary
#   home.packages = [ pkgs.xremap ];
#
#   # user‐level systemd unit to run it at login
#   systemd.user.services.xremap = {
#     Unit = {
#       Description = "xremap daemon";
#       After = [ "graphical-session.target" ];
#     };
#     Service = {
#       # before: ExecStart = ".../xremap --config ~/.config/xremap.yml"
#       ExecStart =
#         "${pkgs.xremap}/bin/xremap ${config.home.homeDirectory}/.config/xremap.yml";
#       Restart = "always";
#     };
#     Install = { WantedBy = [ "default.target" ]; };
#   };
# }
