{
    inputs = {
    	nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    };

    outputs = { self, nixpkgs, nix-flatpak, ... } @inputs: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                nix-flatpak.nixosModules.nix-flatpak
                ./configuration.nix
            ];
        };
    };
}
