{
	inputs = {
		nixpkgs = {
			url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
	};

	outputs = inputs@{
		self,
		nixpkgs,
		home-manager,
		...
	}:let
		variables = {
			system = {
				version = "24.11";
				hostname = "nixos";
			};
			account = {
				eric = {
					name = "eric";
					git = {
						username = "EricRagnarsen";
						email = "ericragnarsen@gmail.com";
					};
				};
			};
		};
	in {
		nixosConfigurations = {
			${variables.system.hostname} = nixpkgs.lib.nixosSystem {
				specialArgs = {
					inherit inputs variables;
				};
				modules = [
					./config
					home-manager.nixosModules.home-manager
				];
			};
		};
	};
}