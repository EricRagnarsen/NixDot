{
	variables,
	...
}: {
	programs = {
		home-manager = {
			enable = true;
		};
	};
	home = {
		stateVersion = variables.system.version;
	};
}