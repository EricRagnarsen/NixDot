{
	pkgs,
	config,
	lib,
	...
}: let
	types = {
		nospace = str: lib.filter (c: c == " ") (lib.stringToCharacters str) == [ ];
		hostname = lib.types.strMatching"^$|^[[:alnum:]]([[:alnum:]_-]{0,61}[[:alnum:]])?$";
		timezone = lib.types.nullOr (lib.types.addCheck lib.types.str types.nospace);
	};
in {
	options.modules.networking = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to enable networking module or not";
		};
		settings = {
			hostname = lib.mkOption {
				type = types.hostname;
				default = config.system.nixos.distroId;
				description = "the name of the machine";
			};
			timezone = lib.mkOption {
				type = types.timezone;
				default = null;
				description = "the system timezone";
			};
			locale = lib.mkOption {
				type = lib.types.str;
				default = "en_US.UTF-8";
				description = "the system language";
			};
		};
	};

	config = lib.mkIf config.modules.networking.enable {
		networking = {
			hostName = config.modules.networking.settings.hostname;
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
			timeZone = config.modules.networking.settings.timezone;
		};
		i18n = {
			defaultLocale = config.modules.networking.settings.locale;
		};
		hardware = {
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
	};
}