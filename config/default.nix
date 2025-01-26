{
	inputs,
	variables,
	...
}: {
	imports = [
		./components
	];
	system = {
		stateVersion = variables.system.version;
	};
	nixpkgs = {
		config = {
			allowUnfree = true;
		};
	};
	nix = {
		settings = {
			experimental-features = "nix-command flakes";
			auto-optimise-store = true;
		};
	};
	documentation = {
		nixos = {
			enable = false;
		};
	};
	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		extraSpecialArgs = {
			inherit inputs variables;
		};
		users = {
			${variables.account.eric.name} = {
				home = {
					username = variables.account.eric.name;
					homeDirectory = "/home/${variables.account.eric.name}";
				};
				imports = [
					./components/home/eric
					inputs.nixvim.homeManagerModules.nixvim
				];
			};
		};
	};
}