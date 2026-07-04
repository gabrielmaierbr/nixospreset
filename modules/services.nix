{ config, pkgs, ... }:
{
	services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
    services.printing.enable = true;

	programs.steam = {
	 	enable = true;
		remotePlay.openFirewall = true;
    	dedicatedServer.openFirewall = true;
	};

	programs.gamemode.enable = true;
	programs.steam.package = pkgs.steam.override {
	  extraPkgs = pkgs': with pkgs'; [
	    libXcursor
	    libXi
	    libXinerama
	    libXScrnSaver
	    libpng
	    libpulseaudio
	    libvorbis
	    stdenv.cc.cc.lib
	    libkrb5
	    keyutils
	  ];
	};
}
