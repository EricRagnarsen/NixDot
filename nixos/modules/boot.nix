{
	pkgs,
	config,
	lib,
	...
}: {
	options.modules.boot = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to enable boot module or not";
		};
		settings = {
			mode = lib.mkOption {
				type = lib.types.enum ["uefi" "legacy"];
				default = "uefi";
				description = "Select the boot mode";
			};
			loader = lib.mkOption {
				type = lib.types.enum ["systemd" "grub"];
				default = "systemd";
				description = "Select the boot loader";
			};
		};
	};

	config = lib.mkIf config.modules.boot.enable {
		boot = {
			loader = {
				efi = lib.mkIf (config.modules.boot.settings.mode == "uefi") {
          			canTouchEfiVariables = true;
        		};
				systemd-boot = lib.mkIf (config.modules.boot.settings.loader == "systemd") {
          			enable = true;
        		};
				grub = lib.mkIf (config.modules.boot.settings.loader == "grub") {
					enable = true;
          			efiSupport = if config.modules.boot.settings.mode == "uefi" then true else false;
          			device = "nodev";
        		};
				timeout = 5;
			};
			tmp = {
				cleanOnBoot = true;
			};
		};
	};
}