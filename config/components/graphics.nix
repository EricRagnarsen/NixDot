{
	pkgs,
	config,
	...
}: {
	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
		};
		nvidia = {
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			open = false;
			modesetting = {
				enable = true;
			};
			prime = {
				nvidiaBusId = "PCI:1:0:0";
				amdgpuBusId = "PCI:5:0:0";
			};
		};
		services = {
			xserver = {
				enable = true;
				videoDrivers = [
					"amdgpu"
					"nvidia"
				];
			};
		};
	};
}