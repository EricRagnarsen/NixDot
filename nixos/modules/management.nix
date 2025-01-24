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
			users = lib.mkOption {
				type = lib.types.attrsOf (lib.types.attrs {
					privilege = lib.types.enum [ "administrator" "user" ];
				});
				default = {};
				description = "Create a user with their privilege";
			};
		};
	};

	config = lib.mkIf config.modules.management.enable {
		users = {
			groups = {
				administrators = {};
				users = {};
			};
			users = lib.genAttrs (lib.attrNames config.modules.management.settings.users) (name: {
				isNormalUser = true;
				initialPassword = name;
				group = if config.modules.management.settings.users.${name}.privilege == "administrator" then "administrators" else "users";
				extraGroups = if config.modules.management.settings.users.${name}.privilege == "administrator" then [ "networkmanager" "video" "audio" ] else [];
			});
		};
	};
}