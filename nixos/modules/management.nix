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
				type = lib.types.attrsOf (lib.types.submodule ({
					privilege = lib.mkOption {
						type = lib.types.enum [ "administrator" "user" ];
						default = "user";
					};
				}));
			};
		};
	};

	config = lib.mkIf config.modules.management.enable {
		users = {
			groups = {
				administrators = {};
				users = {};
			};
			users = lib.mapAttrs (name: cfg: {
				isNormalUser = true;
				initialPassword = name;
				group = if cfg.privilege == "administrator" then "administrators" else "users";
				extraGroups = if cfg.privilege == "administrator" then ["networkmanager" "video" "audio"] else [];
			}) config.modules.management.settings.users;
		};
	};
}