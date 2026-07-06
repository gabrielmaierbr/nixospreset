{ config, pkgs, ... }:
{
    networking.hostName = "nixos";

    users.users."gabrielmaier" = {
    isNormalUser = true;
    description = "Gabriel Maier";
    #password = "123";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
        kdePackages.kate
    ];
  };
}
