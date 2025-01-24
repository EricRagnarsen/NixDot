{
	inputs,
	variables,
	config,
	...
}: {
	imports = [
		./scan/hardware.nix
		./modules/graphic.nix
		./modules/networking.nix
		./modules/boot.nix
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
	hardware = {
		graphic = {
			enable = true;
			enable32Bit = true;
		};
		nvidia = {
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			open = false;
			modesetting = {
				enable = true;
			};
			prime = {
				amdgpuBusId = "PCI:0:2:0";
				nvidiaBusId = "PCI:14:0:0";
			};
		};
		bluetooth = {
			enable = true;
			powerOnBoot = false;
			settings = {
				General = {
					Experimental = true;
				};
			};
		};
	};
	networking = {
		hostName = variables.system.hostname;
		dhcpcd = {
			enable = false;
		};
		networkmanager = {
			enable = true;
		};
		firewall = {
			enable = true;
		};
	};
	time = {
		timeZone = "Asia/Bangkok";
	};
	i18n = {
		defaultLocale = "en_US.UTF-8";
	};
	boot = {
		loader = {
			efi = {
				canTouchEfiVariables = true;
			};
			systemd-boot = {
				enable = true;
			};
			timeout = 5;
		};
		tmp = {
			cleanOnBoot = true;
		};
	};
	users = {
		groups = {
			sudo = {};
		};
		users = {
			${variables.users.administrator.name} = {
				isNormalUser = true;
				initialPassword = variables.users.administrator.name;
				extraGroups = [
					"sudo"
					"networkmanager"
					"video"
					"audio"
					"libvirtd"
				];
			};
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
	hyprland = {
		enable = true;
	};
	services = {
		xserver = {
			videoDrivers = [
				"nvidia"
			];
		};
	};
}