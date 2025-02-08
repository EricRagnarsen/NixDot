{
	variables,
	...
}: {
	programs = {
		git = {
			enable = true;
			extraConfig = {
				core = {
					editor = "nvim";
				};
				color = {
					ui = true;
				};
				push = {
					autoSetupRemote = true;
				};
			};
			userName = variables.account.eric.git.username;
			userEmail = variables.account.eric.git.email;
		};
	};
}