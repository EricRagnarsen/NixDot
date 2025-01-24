{
	inputs,
	pkgs,
	...
}: {
	wayland = {
		windowManager = {
			hyprland = {
				enable = true;
				package = inputs.hyprland.packages.${pkgs.system}.default;
				settings = let
					leader = "super";
				in {
					exec-once = [

					];
					monitor = [
						"eDP-1, 1920x1080@165, 0x0, 1"
						", preferred, auto, 1"
					];
					general = {
						gaps_in = 5;
						gaps_out = 20;
						border_size = 2;
						col.active_border = "rgb(81a1c1)";
						col.inactive_border = "rgb(2e3440)";
						layout = "dwindle";
					};
					decoration = {
						rounding = 10;
						rounding_power = 2;
						shadow = {
							enabled = true;
							range = 20;
							render_power = 4;
							color = "rgb(111111)";
						};
						blur = {
							enabled = true;
							size = 3;
							passes = 1;
							vibrancy = 0.1696;
						};
						misc = {
							disable_hyprland_logo = true;
							disable_splash_rendering = true;
							vrr = 1;
							background_color = "rgb(2e3440)";
						};
						dwindle = {
							pseudotile = true;
							preserve_split = true;
							smart_split = true;
							smart_resizing = true;
						};
						master = {
							new_status = "master";
							new_on_top = true;
							smart_resizing = true;
						};
					};
					animations = {
						enabled = true;
						bezier = [
							"easeOutQuint, 0.23, 1, 0.32, 1"
							"easeInOutCubic, 0.65, 0.05, 0.36, 1"
							"linear, 0, 0, 1, 1"
							"almostLinear, 0.5, 0.5, 0.75, 1.0"
							"quick, 0.15, 0, 0.1, 1"
						];
						animation = [
							"global, 1, 10, default"
							"border, 1, 5.39, easeOutQuint"
							"windows, 1, 4.79, easeOutQuint"
							"windowsIn, 1, 4.1, easeOutQuint, popin 87%"
							"windowsOut, 1, 1.49, linear, popin 87%"
							"fadeIn, 1, 1.73, almostLinear"
							"fadeOut, 1, 1.46, almostLinear"
							"fade, 1, 3.03, quick"
							"layers, 1, 3.81, easeOutQuint"
							"layersIn, 1, 4, easeOutQuint, fade"
							"layersOut, 1, 1.5, linear, fade"
							"fadeLayersIn, 1, 1.79, almostLinear"
							"fadeLayersOut, 1, 1.39, almostLinear"
							"workspaces, 1, 1.94, almostLinear, fade"
							"workspacesIn, 1, 1.21, almostLinear, fade"
							"workspacesOut, 1, 1.94, almostLinear, fade"
						];
					};
					windowrulev2 = [
						"float, class:.*"
						"suppressevent maximize, class:.*"
					];
					bind = let
						binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
						mvfc = binding leader "movefocus";
						chws = binding leader "workspace";
						mvtows = binding "${leader} shift" "movetoworkspace";
						ws = [1 2 3 4 5 6 7 8 9 0];

						terminal = "kitty";
						filemanager = "nautilus";
						taskmanager = "mission-center";
					in [
						"${leader}, q, killactive"
						"${leader}, f, togglefloating"
						"${leader}, f11, fullscreen"
						"${leader}, s, togglesplit"

						"${leader}, t, ${terminal}"
						"${leader}, e, ${filemanager}"
						"${leader}, escape, ${taskmanager}"

						(mvfc "up" "u")
						(mvfc "down" "d")
						(mvfc "left" "r")
						(mvfc "right" "l")
					]
						++ (map (i: chws (if i == 0 then "10" else toString i) (toString i)) ws)
						++ (map (i: mvtows (if i == 0 then "10" else toString i) (toString i)) ws);
					bindm = [
						"${leader}, mouse:273, resizewindow"
						"${leader}, mouse:272, movewindow"
					];
				};
			};
		};
	};
}