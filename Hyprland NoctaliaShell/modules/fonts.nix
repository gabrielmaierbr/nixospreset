{ config, pkgs, ... }:
{
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        jetbrains-mono
        nerd-fonts.jetbrains-mono
        fira-code
        fira-code-symbols
    ];
}
