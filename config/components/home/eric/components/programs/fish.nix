{
	pkgs,
	...
}: {
	programs = {
		fish = {
			enable = true;
			function = {
				uwsm-greeter = {
					onEvent = "tty";
					body =
						''
							if test "$TTY" = "/dev/tty1"
								if uwsm check may-start and uwsm select
									exec systemd-cat -t uwsm_start uwsm start default
								end
							end
						''
					;
				};
			};
			interactiveShellInit = "uwsm-greeter";
			plugins = [
				{
					name = "pure";
					src = pkgs.fetchFromGitHub {
						owner = "pure-fish";
						repo = "pure";
						rev = "28447d2e7a4edf3c954003eda929cde31d3621d2";
						sha256 = "1hfj0qskih0qwpzd57m4a9nlcls4mnb0s672295pc1a676sn7vk1";
					};
				}
				{
					name = "transient";
					src = pkgs.fetchFromGitHub {
						owner = "zzhaolei";
						repo "transient.fish";
						rev = "883a1ec3c0163883d56db38b2b58579e2a5b9739";
						sha256 = "0jw3h5dxy3k2jbl6w0y8v1plwi8h8l6509dmmjwy425jpmdyvsc2";
					};
				}
			];
		};
	};
}