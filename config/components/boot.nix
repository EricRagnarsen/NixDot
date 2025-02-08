{
	pkgs,
	...
}: {
	boot = {
		loader = {
			efi = {
				canTouchEfiVariables = true;
			};
			systemd-boot = {
				enable = true;
			};
			timeout = 0;
		};
		initrd = {
			kernelModules = [
				"amdgpu"
			];
		};
		kernelParams = [
			"quiet"
			"splash"
			"rd.systemd.show_status=false"
			"rd.udev.log_level=3"
			"udev.log_priority=3"
		];
		consoleLogLevel = 0;
		plymouth = {
			enable = true;
			theme = "spinner_alt";
			themePackages = with pkgs; [
				(adi1090x-plymouth-themes.override {
					selected_themes = [
						"spinner_alt"
					];
				})
			];
		};
		tmp = {
			cleanOnBoot = true;
		};
	};
}