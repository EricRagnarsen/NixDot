{
	inputs,
	pkgs,
	config,
	...
}: {
	wayland = {
		windowManager = {
			hyprland = {
				enable = true;
				package = inputs.hyprland.packages.${pkgs.system}.default;
				xwayland = {
					enable = true;
				};
				systemd = {
					enable = false;
				};
				settings = {
					monitor = [
						"eDP-1, 1920x1080@165, 0x0, 1"
						", preferred, auto, 1"
					];
					general = {
						gaps_in = 5;
						gaps_out = 20;
						border_size = 2;
						col.active_border = "rgb(7dcfff)";
						col.inactive_border = "rgb(1f2335)";
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
						};
						misc = {
							disable_hyprland_logo = true;
							disable_splash_rendering = true;
							vrr = 1;
							background_color = "rgb(24283b)";
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
					"$leader" = "super";
					"$screenlock" = "hyprlock";
					"$terminal" = "kitty";
					"$filemanager" = "nautilus";
					"$taskmanager" = "mission-center";
					bind = [
						"$leader, q, killactive"
						"$leader, f, togglefloating"
						"$leader, f11, fullscreen"
						"$leader, s, togglesplit"
						"$leader, left, movefocus, l"
						"$leader, right, movefocus, r"
						"$leader, up, movefocus, u"
						"$leader, down, movefocus, d"
						"$leader, 1, workspace, 1"
						"$leader, 2, workspace, 2"
						"$leader, 3, workspace, 3"
						"$leader, 4, workspace, 4"
						"$leader, 5, workspace, 5"
						"$leader, 6, workspace, 6"
						"$leader, 7, workspace, 7"
						"$leader, 8, workspace, 8"
						"$leader, 9, workspace, 9"
						"$leader, 0, workspace, 10"
						"$leader shift, 1, movetoworkspace, 1"
						"$leader shift, 2, movetoworkspace, 2"
						"$leader shift, 3, movetoworkspace, 3"
						"$leader shift, 4, movetoworkspace, 4"
						"$leader shift, 5, movetoworkspace, 5"
						"$leader shift, 6, movetoworkspace, 6"
						"$leader shift, 7, movetoworkspace, 7"
						"$leader shift, 8, movetoworkspace, 8"
						"$leader shift, 9, movetoworkspace, 9"
						"$leader shift, 0, movetoworkspace, 10"
						"$leader shift, l, uwsm app -- $screenlock"
						"$leader, t, uwsm app -- $terminal"
						"$leader, e, uwsm app -- $filemanager"
						"$leader, escape, uwsm app -- $taskmanager"
					];
					bindm = [
						"$leader, mouse:273, resizewindow"
						"$leader, mouse:272, movewindow"
					];
				};
			};
		};
	};
	programs = {
		hyprlock = {
			enable = true;
			settings = {
				general = {
					disable_loading_bar = true;
					hide_cursor = true;
					grace = 300;
					ignore_empty_input = true;
				};
				background = [
					{
						monitor = "";
						path = "screenshot";
						blur_passes = 2;
						blur_size = 7;
					}
				];
				label = [
					{
						monitor = "";
						text = "$TIME12";
						color = "rgb(7dcfff)";
						font_size = 90;
						font_family = "RobotoMono Nerd Font Bold";
						position = "0, 80";
						halign = "center";
						valign = "center";
					}
				];
				input-field = [
					{
						monitor = "";
						size = "300, 70";
						outline_thickness = 2;
						dots_size = 0.3;
						dots_spacing = 0.3;
						dots_center = true;
						outer_color = "rgb(444b6e)";
						inner_color = "rgb(1f2335)";
						font_color = "rgb(444b6e)";
						font_family = "RobotoMono Nerd Font Bold";
						fade_on_empty = true;
						placeholder_text = "";
						rounding = -1;
						check_color = rgb(e2a478);
						fail_color = rgb(c53b53);
						fail_text = "";
						position = "0, -80";
						halign = "center";
						valign = "center";
					}
				];
			};
		};
	};
	home = {
		packages = with pkgs; [
			nerd-fonts.roboto-mono
			brightnessctl
			pulsemixer
			wl-clipboard
			mission-center
			nautilus
			nautilus-open-any-terminal
		];
	};
	services = {
		hypridle = {
			enable = true;
			settings = {
				general = {
					ignore_dbus_inhibit = false;
					lock_cmd = "hyprlock";
					after_sleep_cmd = "hyprctl dispatch dpms on";
				};
				listener = [
					{
						timeout = 150;
						on-timeout = "brightnessctl -s set 10";
						on-resume = "brightnessctl -r";
					}
					{
						timeout = 150;
						on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
						on-resume = "brightnessctl -rd rgb:kbd_backlight";
					}
					{
						timeout = 300;
						on-timeout = "loginctl lock-session";
					}
					{
						timeout = 305;
						on-timeout = "hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}
					{
						timeout = 600;
						on-timeout = systemctl suspend;
					}
				];
			};
		};
		hyprpaper = {
			enable = false;
			settings = {
				ipc = false;
				splash = false;
				preload = [];
				wallpaper = [];
			};
		};
	};
	gtk = {
		enable = true;
		theme = {
			name = "Tokyonight-Dark";
			package = pkgs.tokyonight-gtk-theme.override {
				colorVariants = [
					"dark"
				];
				sizeVariants = [
					"standard"
				];
				themeVariants = [
					"default"
				];
				tweakVariants = [
					"storm"
				];
				iconVariants = [
					"Dark"
				];
			};
		};
		iconTheme = {
			name = "Colloid-Catppuccin-Dark";
			package = pkgs.colloid-icon-theme.override {
				schemeVariants = [
					"catppuccin"
				];
				colorVariants = [
					"default"
				];
			};
		};
		cursorTheme = {
			name = "Qogir-dark";
			package = pkgs.qogir-icon-theme.override {
				colorVariants = [
					"all"
				];
				themeVariants = [
					"default"
				];
			};
			size = 32;
		};
		font = {
			name = "RobotoMono Nerd Font";
			package = pkgs.nerd-fonts.roboto-mono;
			size = 10;
		};
	};
	qt = {
		enable = true;
		platformTheme = {
			name = "qtct";
		};
		style = {
			name = "kvantum";
		};
	};
	xdg = {
		configFile = {
			"uwsm/env" = {
				text = builtins.concatStringsSep "\n" (map (env: "export " + env) [
        			"GTK_THEME=${config.gtk.theme.name}"
        			"XCURSOR_THEME=${config.gtk.cursorTheme.name}"
        			"XCURSOR_SIZE=${toString config.gtk.cursorTheme.size}"
        			"QT_QPA_PLATFORM=wayland"
        			"QT_QPA_PLATFORMTHEME=qt5ct"
      			]);
			};
			"uwsm/env-hyprland" = {
				text = builtins.concatStringsSep "\n" (map (env: "export " + env) [
        			"AQ_DRM_DEVICE=\"/dev/dri/card2:/dev/dri/card1\""
      			]);
			};
			"qt5ct/qt5ct.conf" = {
				source = pkgs.formats.ini { }.generate "qt5ct.conf" {
					Appearance = {
						icon_theme = "Colloid-Catppuccin-Dark";
						font = "RobotoMono Nerd Font,10";
					};
				};
			};
		};
	};
}