{
	pkgs,
	config,
	lib,
	...
}: {
	options.dnssec = {
		enable = lib.mkEnableOption "Wether to enable dns module";
	};

	config = lib.mkIf config.dnssec.enable {
		networking = {
			nameservers = [
				"::1"
			];
			firewall = {
				allowedTCPPorts = lib.mkIf config.networking.firewall.enable [ 3001 5335 ];
			};
		};
		services = {
			dnscrypt-proxy2 = {
				enable = true;
				settings = {
					listen_addresses = [ "[::1]:5335" ];
					ipv6_servers = true;
					require_dnssec = true;
					sources = {
						public-resolvers = {
							urls = [
								"https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
								"https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
							];
							cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
							minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
						};
					};
				};
			};
			adguardhome = {
				enable = true;
				host = "::1";
				port = "3001";
				openFirewall = true;
				settings = {
					dns = {
						upstream_dns = [
							"[::1]:5335"
						];
					};
					filtering = {
						protection_enabled = true;
						filtering_enabled = true;
						parental_enabled = false;
						safe_search = {
							enable = false;
						};
					};
				};
			};
		};
		systemd = {
			services = {
				dnscrypt-proxy2 = {
					serviceConfig = {
						StateDirectory = "dnscrypt-proxy";
					};
				};
			};
		};
	};
}