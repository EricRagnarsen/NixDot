{
	variables,
	...
}: {
	imports = [
		./windowmanager/hyprland.nix
		./programs/kitty.nix
		./programs/nixvim.nix
		./utilities/git.nix
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