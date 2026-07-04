{ config, pkgs, ... }:
{
	users.users."gabrielmaier" = {
	    	isNormalUser = true;
	    	description = "Gabriel Maier";
	    	extraGroups = [ "networkmanager" "wheel" ];
			#password = "1234";
			shell = pkgs.fish;
	    	packages = with pkgs; [
				
	    	];
	};
}