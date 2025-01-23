{
	inputs = {
		nixpkgs = {
			url = "github:nixos/nixpkgs/nixpkgs-unstable";
		};
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs = {
				nixpkgs = {
					follows = "nixpkgs";
				};
			};
		};
		hyprland = {
			url = "github:hyprwm/Hyprland";
			inputs = {
				nixpkgs = {
					follows = "nixpkgs";
				};
			};
		};
		nixvim = {
			url = "github:nix-community/nixvim";
			inputs = {
				nixpkgs = {
					follows = "nixpkgs";
				};
			};
		};
	};

	outputs = inputs@{
		self,
		nixpkgs,
		home-manager,
		...
	}: let
		variables = {
			system = {
				version = "24.11";
			};
			users = {
				administrator = {
					username = "ericragnarsen";
					name = "eric";
					email = "ericragnarsen@gmail.com";
				};
			};
		};
	in {
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				specialArgs = {
					inherit inputs variables;
				};
				modules = [
					./nixos/nixos.nix
					home-manager.nixosModules.home-manager
				];
			};
		};
	};
}