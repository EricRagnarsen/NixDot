{
	variables,
	...
}: {
	users = {
		groups = {
			administrators= {};
			user = {};
		};
		users = {
			${variables.account.eric.name} = {
				isNormalUser = true;
				initialPassword = variables.account.eric.name;
				group = "administrator";
				extraGroups = [
					"networkmanager"
					"video"
					"audio"
					"libvirtd"
				];
			};
		};
	};
}