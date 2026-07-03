{ config, pkgs, ... }:
{
    services.udisks2.enable = true;
    services.gvfs.enable = true;
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
    };
}

