{
	variables,
	...
}: {
	imports = [
		./components
	];
	programs = {
		home-manager = {
			enable = true;
		};
	};
	home = {
		stateVersion = variables.system.version;
	};
}