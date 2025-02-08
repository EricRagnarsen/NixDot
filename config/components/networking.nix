{
	variables,
	...
}: {
	networking = {
		hostName = variables.system.hostname;
		nameservers = [
			"127.0.0.1"
			"::1"
		];
		dhcpcd = {
			enable = false;
		};
		networkmanager = {
			enable = true;
			dns = "none";
		};
		firewall = {
			enable = false;
		};
	};
	services = {
		dnsmasq = {
			enable = true;
			settings = {
				no-resolv = true;
				server = [
					"127.0.0.1:53"
					"[::1]:53"
				];
			};
		};
		dnscrypt-proxy2 = {
			enable = true;
			settings = {
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
				server_names = [
					"adguard-dns-doh"
				];
				anonymized_dns = true;
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
}