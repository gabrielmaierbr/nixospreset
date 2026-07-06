{ config, pkgs, ... }:
{
    services.displayManager.sddm.enable = true;
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
}
