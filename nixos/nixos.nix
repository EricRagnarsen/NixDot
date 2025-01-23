{
	variables,
	...
}: let
	system = import ./variables/system.nix
	users = import ./variables/users.nix
in {
	imports = [
		./modules/dnssec.nix
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
		nvidia = {
			package = config.boot.kernelPackages.nvidiaPackages.stable;
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
	security = {
		rtkit = {
			enable = true;
		};
	};
	networking = {
		networkmanager = {
			enable = true;
		};
		firewall = {
			enable = true;
		};
	};
	dnssec = {
		enable = true;
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
		users = {
			${users.administrator.name} = {
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
			inherit inputs;
		};

	};
	hyprland = {
		enable = true;
	};
	services = {
		pipewire = {
			enable = true;
			wireplumber = {
				enable = true;
			};
			alsa = {
				enable = true;
				support32Bit = true
			};
			pulse = {
				enable = true;
			};
		};
	};
}