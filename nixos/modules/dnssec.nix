{
	pkgs,
	config,
	lib,
	...
}: {
	options.dnssec = {
		enable = lib.mkEnableOption "Whether to enable DNS security";
	};

	config = lib.mkIf config.dnssec.enable {
		networking = {
			firewall = {
				allowedTCPPorts = lib.mkIf config.networking.firewall.enable [ 853 ];
			};
		};
		services = {
			adguardhome = {
				enable = true;
				host = "127.0.0.1";
				port = 3001;
				openFirewall = true;
				settings = {
					users = {
						name = "adguard";
						password = "$2a$20$pxAwdjWPsZE7LbJsP9ks8uhdGrXgSfUxYT9Y3wQFzZl1MqOj287AW";
					};
					dns = {
						upstream_dns = [
							"tls://1.1.1.1:853"
							"tls://1.0.0.1:853"
						];
					};
					tls = {
						enabled = true;
					};
					filtering = {
						protection_enabled = true;
						filtering_enabled = true;
					};
				};
			};
		};
	};
}