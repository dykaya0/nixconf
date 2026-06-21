{
	description = "NixOS Config";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-26.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }: 
        let
			system = "x86_64-linux";
            mkHost = hostname:
                nixpkgs.lib.nixosSystem {
                    inherit system;

                    specialArgs = {
                        inherit self;
                    };

                    modules = [
                        ./hosts/${hostname}/configuration.nix

                        home-manager.nixosModules.home-manager
                        {
                            home-manager = {
                                useGlobalPkgs = true;
                                useUserPackages = true;
                                users.dogukan = import ./home/dogukan.nix;
                                backupFileExtension = "backup";
                            };
                        }
                    ];
                };
        in
        {
		nixosConfigurations = {
            desktop = mkHost "desktop";
            laptop = mkHost "laptop";

		};
	};
}
