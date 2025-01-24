{
	pkgs,
	config,
	lib,
	...
}: let
	types = {
		busId = lib.types.strMatching "([[:print:]]+[:@][0-9]{1,3}:[0-9]{1,2}:[0-9])?";
	};
in {
	options.modules.graphics = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to enable graphic module or not";
		};
		settings = {
			gpu = lib.mkOption {
				type = lib.types.enum ["nvidia" "amd" "intel" "generic"];
				default = "generic";
				description = "Select the GPU";
			};
			nvidia = {
				prime = {
					busId = {
						nvidia = lib.mkOption {
							type = types.busId;
							default = "";
							description = "Bus ID of the NVIDIA GPU";
						};
						amd = lib.mkOption {
							type = types.busId;
							default = "";
							description = "Bus ID of the AMD GPU";
						};
						intel = lib.mkOption {
							type = types.busId;
							default = "";
							description = "Bus ID of the Intel GPU";
						};
					};
				};
			};
		};
	};

	config = lib.mkIf config.modules.graphics.enable {
		hardware = {
			graphics = {
				enable = true;
				enable32Bit = true;
				extraPackages = pkgs.lib.optionals (config.modules.graphics.settings.gpu == "amd") [pkgs.rocmPackages.clr.icd]
				++ pkgs.lib.optionals (config.modules.graphics.settings.gpu == "intel") [pkgs.vpl-gpu-rt];
			};
			nvidia = lib.mkIf (config.modules.graphics.settings.gpu == "nvidia") {
				package = config.boot.kernelPackages.nvidiaPackages.stable;
				open = false;
				modesetting = {
					enable = true;
				};
				prime = {
					nvidiaBusId = config.modules.graphics.settings.nvidia.prime.busId.nvidia;
					amdgpuBusId = config.modules.graphics.settings.nvidia.prime.busId.amd;
					intelBusId = config.modules.graphics.settings.nvidia.prime.busId.intel;
				};
			};
		};
		services = {
			xserver = {
				enable = true;
				videoDrivers = pkgs.lib.optionals (config.modules.graphics.settings.gpu == "nvidia") ["nvidia"];
			};
		};
		assertions = [
			{
				assertion = !(config.modules.graphics.settings.nvidia.prime.busId.nvidia != "" && config.modules.graphics.settings.nvidia.prime.busId.amd == "" && config.modules.graphics.settings.nvidia.prime.busId.intel == "");
				message = "NVIDIA bus ID cannot be set without either AMD or Intel bus ID being set";
			}
			{
				assertion = !(config.modules.graphics.settings.nvidia.prime.busId.nvidia == "" && (config.modules.graphics.settings.nvidia.prime.busId.amd != "" || config.modules.graphics.settings.nvidia.prime.busId.intel != ""));
				message = "You cannot set AMD or Intel bus ID without setting an NVIDIA bus ID";
			}
			{
				assertion = !(config.modules.graphics.settings.nvidia.prime.busId.amd != "" && config.modules.graphics.settings.nvidia.prime.busId.intel != "");
				message = "You can only set one of AMD or Intel bus ID when using NVIDIA Prime";
			}
		];
	};
}