{ config, pkgs, inputs, ... }:
{
  home.username = "gabrielmaier";
  home.homeDirectory = "/home/gabrielmaier";
  home.stateVersion = "26.05";

  imports = [
    inputs.noctalia.homeModules.default
    ./modules/terminal.nix
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      # configs do bar/widgets aqui depois
    };
  };

  programs.home-manager.enable = true;
}