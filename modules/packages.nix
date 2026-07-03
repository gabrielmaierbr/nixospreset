{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
  		brave
		discord
		equicord
		steam
		spotify
		noctalia-shell
		kitty
		foot
		vscode
		git
		protonplus
		kdePackages.qt6ct
		nwg-look
		adw-gtk3
		tela-circle-icon-theme
		bibata-cursors
		nautilus
		thunar
		gvfs
		udisks2
  	];
}
