{ config, pkgs, ... }:
{
    services.xserver.enable = true;
    services.printing.enable = true;
    programs.fish.enable = true;
}
