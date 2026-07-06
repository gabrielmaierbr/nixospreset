{ config, pkgs, ... }:
{
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        vim
        git
        rofi
        cava
        brave
        discord
        equicord
        spotify
        protonplus
        vscode
        heroic
        plasma-panel-colorizer
        tela-circle-icon-theme
        papirus-folders
        papirus-icon-theme
        bibata-cursors
        klassy
        starship
        kitty
        lact
        wineWow64Packages.stableFull
        wineWow64Packages.waylandFull
        wine
        wine64
        winetricks
        obs-studio
        vlc
        faugus-launcher
        prismlauncher
    ];
}
