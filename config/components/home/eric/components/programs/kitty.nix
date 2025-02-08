{
	pkgs,
	...
}: {
	programs = {
		kitty = {
			enable = true;
			themeFile = "Tokyo_Night_Storm";
			font = {
				name = "RobotoMono Nerd Font";
				package = pkgs.nerd-fonts.roboto-mono;
				size = 11;
			};
			settings = {
				window_padding_width = 10;
				background_opacity = 0.9;
			};
		};
	};
}