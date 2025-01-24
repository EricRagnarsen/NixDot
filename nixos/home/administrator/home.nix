{
	variables,
	...
}: {
	imports = [
		./nixvim.nix
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