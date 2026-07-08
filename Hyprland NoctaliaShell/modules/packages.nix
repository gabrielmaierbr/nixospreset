{ config, pkgs, ... }:
{
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        vim
        git
        rofi
        cava
        noctalia-shell
        nwg-look
        kdePackages.qt6ct
        patch
        nautilus
        brave
        discord
        equicord
        spotify
        protonplus
        vscode
        heroic
        tela-circle-icon-theme
        papirus-folders
        papirus-icon-theme
        bibata-cursors
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
        stremio-linux-shell
    ];
}
