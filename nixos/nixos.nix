{
	inputs,
	variables,
	config,
	...
}: {
	imports = [
		./scan/hardware.nix
		./modules/boot.nix
		./modules/graphics.nix
		./modules/networking.nix
		./modules/management.nix
		./modules/security.nix
		./modules/hyprland.nix
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
			${variables.users.administrator.name} = {
				home = {
					username = variables.users.administrator.name;
					homeDirectory = "/home/${variables.users.administrator.name}";
				};
				imports = [
					./home/administrator/home.nix
					inputs.nixvim.homeManagerModules.nixvim
				];
			};
		};
	};
	modules = {
		boot = {
			enable = true;
			settings = {
				mode = "uefi";
				loader = "systemd";
			};
		};
		graphics = {
			enable = true;
			settings = {
				gpu = "nvidia";
				prime = {
					busId = {
						nvidia = "PCI:14:0:0";
						amd = "PCI:0:2:0";
					};
				};
			};
		};
		networking = {
			enable = true;
			settings = {
				hostname = variables.system.hostname;
				timezone = "Asia/Bangkok";
				locale = "en_US.UTF-8";
			};
		};
		management = {
			enable = true;
			settings = {
				users = {
					${variables.users.administrator.name} = {
						privilege = "administrator";
					};
				};
			};
		};
		security = {
			enable = true;
		};
		hyprland = {
			enable = true;
		};
	};
}