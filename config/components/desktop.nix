{
	inputs,
	pkgs,
	...
}: {
	nix = {
		settings = {
			substituters = ["https://hyprland.cachix.org"];
			trusted-public-keys = [
				"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
			];
		};
	};
	fonts = {
		fontconfig = {
			enable = true;
			defaultFonts = {
				serif = [
					"Noto Serif"
				];
				sansSerif = [
					"Noto Sans"
				];
				monospace = [
					"Noto Color Emoji"
				];
			};
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
		uwsm = {
			enable = true;
		};
		dconf = {
			enable = true;
		};
		hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
			xwayland = {
				enable = true;
			};
			withUWSM = true;
		};
	};
	environment = {
		systemPackages = with pkgs; [
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-color-emoji
		];
	};
	security = {
		rtkit = {
			enable = true;
		};
	};
	services = {
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
	};
}