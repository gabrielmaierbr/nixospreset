{ config, pkgs, ... }:
{
	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = with pkgs; [
  		brave
		discord
		equicord
		spotify
		noctalia-shell
		vscode
		git
		protonplus
		kdePackages.qt6ct
		nwg-look
		adw-gtk3
		tela-circle-icon-theme
		bibata-cursors
		nautilus
		gvfs
		udisks2
		lact
		heroic
		wineWow64Packages.stableFull
		wineWow64Packages.waylandFull
		wine
		wine64
		winetricks
  	];
}
