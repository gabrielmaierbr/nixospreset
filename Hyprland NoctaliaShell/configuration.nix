{ config, pkgs, ... }:
{
	imports =
	[
		./hardware-configuration.nix
		./modules/bootloader.nix
		./modules/kernel.nix
		./modules/services.nix
		./modules/amd-gpu.nix
		./modules/audio.nix
		./modules/user.nix
		./modules/packages.nix
		./modules/flatpak-packages.nix
		./modules/fonts.nix
		./modules/gaming.nix
		./modules/desktop-env.nix
		./modules/network.nix
		./modules/locale.nix
		./modules/input.nix
		./modules/aliases.nix
		./modules/garbage.nix
	];

	system.stateVersion = "26.05";

	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
	};
}
