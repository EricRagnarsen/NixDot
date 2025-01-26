{
	...
}: {
	security = {
		sudo = {
			enable = false;
		};
		doas = {
			enable = true;
			extraRules = [
				{
					groups = [
						"administrator"
					];
				}
			];
		};
		polkit = {
			enable = true;
			adminIdentities = [
				"unix-group:administrator"
			];
		};
	};
}