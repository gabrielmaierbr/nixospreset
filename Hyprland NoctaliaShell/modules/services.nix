{ config, pkgs, ... }:
{
    services.xserver.enable = true;
    services.printing.enable = true;
    programs.fish.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
}
