{
	inputs,
	pkgs,
	config,
	lib,
	...
}: {
	options.modules.hyprland = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to enable Hyprland compositor or not";
		};
	};

	config = lib.mkIf config.modules.hyprland.enable {
		nix = {
			settings = {
				substituters = ["https://hyprland.cachix.org"];
				trusted-public-keys = [
					"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
				];
			};
		};
		xdg = {
			portal = {
				enable = true;
				extraPortals = with pkgs; [
					xdg-desktop-portal-gtk
				];
			};
		};
		programs = {
			hyprland = {
				enable = true;
				package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
				portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
				xwayland = {
					enable = true;
				};
			};
		};
		environment = {
			systemPackages = with pkgs; [
				noto-fonts
				noto-fonts-cjk-sans
				noto-fonts-color-emoji
				nerd-fonts.fira-code
				gnome-control-center
				mission-center
				nautilus
				nautilus-open-any-terminal
				baobab
				gnome-clocks
				gnome-calendar
				gnome-weather
				gnome-font-viewer
				wl-clipboard
				kitty
				imv
				mpv
				firefox
			];
		};
		security = {
			rtkit = {
				enable = true;
			};
		};
		services = {
			greetd = {
				enable = true;
				settings = {
					default_session = {
						command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
					};
				};
			};
			upower = {
				enable = true;
			};
			power-profiles-daemon = {
				enable = true;
			};
			gvfs = {
				enable = true;
			};
			udisks2 = {
				enable = true;
			};
			devmon = {
				enable = true;
			};
			accounts-daemon = {
				enable = true;
			};
			gnome = {
				evolution-data-server = {
					enable = true;
				};
				glib-networking = {
					enable = true;
				};
				gnome-keyring = {
					enable = true;
				};
				gnome-online-accounts = {
					enable = true;
				};
				tinysparql = {
					enable = true;
				};
				localsearch = {
					enable = true;
				};
			};
			pipewire = {
				enable = true;
				wireplumber = {
					enable = true;
				};
				alsa = {
					enable = true;
					support32Bit = true;
				};
				pulse = {
					enable = true;
				};
			};
		};
		systemd = {
			user = {
				services = {
					polkit-gnome-authentication-agent-1 = {
						description = "polkit-gnome-authentication-agent-1";
						wantedBy = [
							"graphical-session.target"
						];
						wants = [
							"graphical-session.target"
						];
						after = [
							"graphical-session.target"
						];
						serviceConfig = {
							Type = "simple";
							ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
							Restart = "on-failure";
							RestartSec = 1;
							TimeoutStopSec = 10;
						};
					};
				};
			};
			tmpfiles = {
				rules = [
					"d '/var/cache/greeter' - greeter greeter - -"
				];
			};
		};
	};
}