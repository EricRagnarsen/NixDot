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
				description = "Users who have administrator privilege";
			};
			users = lib.mkOption {
				type = lib.types.listOf lib.types.str;
				default = [];
				description = "Users who have regular privilege";
			};
		};
	};

	config = lib.mkIf config.modules.management.enable {
		users = lib.mkMerge [
			{
				groups = {
					administrators = {};
					users = {};
				;
			}
	      	(lib.mkIf (config.modules.management.settings.administrators != []) {
				users = lib.lists.mapAttrs (name: _) (lib.lists.map (admin: {
					group = "administrators";
					isNormalUser = true;
					initialPassword = "${admin}";
					extraGroups = [
						"networkmanager"
						"video"
						"audio"
					];	
	        	}) config.modules.management.settings.administrators);
			})
			(lib.mkIf (config.modules.management.settings.users != []) {
				users = lib.lists.mapAttrs (name: _) (lib.lists.map (user: {
					group = "users";
					isNormalUser = true;
					initialPassword = "${user}";
				}) config.modules.management.settings.users);
			})
    	];
	};
}