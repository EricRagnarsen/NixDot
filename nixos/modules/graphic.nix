{
	pkgs,
	config,
	lib,
	...
}: let
	busId = lib.types.strMatching "([[:print:]]+[:@][0-9]{1,3}:[0-9]{1,2}:[0-9])?";
in {
	options.graphic = {
		enable = lib.mkEnableOption "Whether to enable graphic module";
		settings = {
			gpu = lib.mkOption {
				type = lib.types.enum [ "nvidia" "amd" "intel" "generic" ];
				default = "generic";
				description = "Select the GPU";
			};
			nvidia = {
				prime = {
					busId = {
						nvidia = lib.mkOption {
							type = busId;
							default = "";
							description = "Bus ID of the NVIDIA GPU";
						};
						amd = lib.mkOption {
							type = busId;
							default = "";
							description = "Bus ID of the AMD GPU";
						};
						intel = lib.mkOption {
							type = busId;
							default = "";
							description = "Bus ID of the Intel GPU";
						};
					};
				};
			};
		};
	};

	config = lib.mkIf config.graphic.enable {
		hardware = {
			graphic = {
				enable = true;
				enable32Bit = true;
			};
		};
		(lib.mkMerge [
			(lib.mkIf config.graphic.settings.gpu == "nvidia" {
      			nvidia = {
					package = config.boot.kernelPackages.nvidiaPackages.stable;
					open = false;
					modesetting = {
						enable = true;
					};
					prime = {
						nvidiaBusId = config.graphic.settings.nvidia.prime.busId.nvidia;
						amdgpuBusId = config.graphic.settings.nvidia.prime.busId.amd;
						intelBusId = config.graphic.settings.nvidia.prime.busId.intel;
					};
				};
				services = {
					xserver = {
						videoDrivers = [
							"nvidia"
						];
					};
				};
    		})
    		(lib.mkIf config.graphic.settings.gpu == "amd" {
      			hardware = {
					graphic = {
						extraPackages = with pkgs; [
							rocmPackages.clr.icd
						];
					};
				};
    		})
    		(lib.mkIf config.graphic.settings.gpu == "intel" {
      			hardware = {
					graphic = {
						extraPackages = with pkgs; [
							vpl-gpu-rt
						];
					};
				};
    		})
		])
	};
}