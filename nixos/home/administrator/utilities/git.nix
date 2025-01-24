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
				push = {
					autoSetupRemote = true;
				};
				color = {
					ui = true;
				};
			};
			userEmail = variables.users.administrator.git.email;
			userName = variables.users.administrator.git.username;
		};
	};
}