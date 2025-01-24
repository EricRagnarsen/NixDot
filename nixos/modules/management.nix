{
	pkgs,
	config,
	lib,
	...
}: {
	options.modules.management = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to enable management module or not";
		};
		settings = {
			administrators = lib.mkOption {
				type = lib.types.listOf lib.types.str;
				default = [];
				description = "List of administrators";
			};
			users = lib.mkOption {
				type = lib.types.listOf lib.types.str;
				default = [];
				description = "List of users";
			};
		};
	};

	config = lib.mkIf config.modules.management.enable {
		users = {
			groups = {
				sudo = {};
			};
			users = lib.concatLists [
				lib.flattenAttrs (adminName: {
					${adminName} = {
						isNormalUser = true;
						initialPassword = adminName;
						extraGroups = [
							"sudo"
							"networkmanager"
							"video"
							"audio"
							"libvirtd"
						];
					};
				}) config.modules.management.settings.administrators
				lib.flattenAttrs (userName: {
					${userName} = {
						isNormalUser = true;
						initialPassword = userName;
					};
				}) config.modules.management.settings.users
			];
    	};
	};
}