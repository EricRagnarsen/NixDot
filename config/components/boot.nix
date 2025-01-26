{
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
			timeout = 5;
		};
		kernelParams = [
			"quiet"
			"rd.systemd.show_status=false"
			"rd.udev.log_level=3"
			"udev.log_priority=3"
		];
		consoleLogLevel = 0;  
		initrd = {
			kernelModules = [
				"amdgpu"
			];
		};
		tmp = {
			cleanOnBoot = true;
		};
	};
}