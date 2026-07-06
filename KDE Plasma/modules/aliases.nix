{ config, pkgs, ... }:
{
    programs.fish.shellAliases = {
        nix-apps = "sudo vim /etc/nixos/modules/packages.nix";
        nix-rebuild = "sudo nixos-rebuild switch";
        flatpak-install = "flatpak install flathub";
        nix-clear = "nix-collect-garbage";
        nix-clear-all = "sudo nix-collect-garbage -d";
    };
}
