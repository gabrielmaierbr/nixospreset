{ config, pkgs, ... }:
{
    networking.networkmanager.enable = true;
    networking.wireless.enable = true;
    hardware.bluetooth.enable = true;
}
