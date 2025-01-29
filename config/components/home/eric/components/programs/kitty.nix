{
	pkgs,
	...
}: {
	programs = {
		kitty = {
			enable = true;
			themeFile = "Nord";
			font = {
				name = "FiraCode Nerd Font";
				package = pkgs.nerd-fonts.fira-code;
				size = 11;
			};
			settings = {
				window_padding_width = 10;
				background_opacity = 0.9;
			};
		};
	};
}