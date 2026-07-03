{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/driversAMD.nix
      ./modules/bootloader.nix
      ./modules/kernel.nix
      ./modules/network.nix
      ./modules/locale.nix
      ./modules/audio.nix
      ./modules/packages.nix
      ./modules/input.nix
      ./modules/user.nix
      ./modules/sddm.nix
      ./modules/hyprland.nix
      ./modules/storageOptimization.nix
    ];

  networking.hostName = "nixos";
  
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.printing.enable = true;
  
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };
}
