# boot.nix

{ ... }: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;

  # boot.kernelModules = [ "amdgpu" ];

  boot.loader.efi.canTouchEfiVariables = true;

  # boot.kernelParams = [ "video=1280x720" ];

  boot.initrd.luks.devices."nixoscrypt".device = "/dev/nvme0n1p5";
  boot.resumeDevice = "/dev/disk/by-uuid/cba6b9b8-55cf-46eb-9122-84dd99cb0138";
  swapDevices = [{ device = "/dev/nixos/swap"; }];
  boot.kernelParams = [ "resume=UUID=cba6b9b8-55cf-46eb-9122-84dd99cb0138" ];
}
