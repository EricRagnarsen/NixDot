{
	pkgs,
	config,
	lib,
	...
}: {
	options.modules.security = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = config.modules.management.enable;
			description = "Whether to enable security module or not";
		};
	};

	config = lib.mkIf config.modules.security.enable {
		security = {
			polkit = {
				enable = true;
				adminIdentities = [
					"unix-group:sudo"
				];
			};
		};
	};
}