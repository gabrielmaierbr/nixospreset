{ config, pkgs, ... }:
{
    programs.fish.shellAliases = {
        nix-apps = "sudo nano /etc/nixos/modules/packages.nix";
        nix-conf-dir = "cd /etc/nixos";
        nix-rebuild = "sudo nixos-rebuild switch";
        nix-rebuild-flake = "sudo nixos-rebuild switch --flake .#nixos";
        flatpak-install = "flatpak install flathub";
        nix-clear = "nix-collect-garbage";
        nix-clear-all = "sudo nix-collect-garbage -d";
    };
}
