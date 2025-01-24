{
	...
}: {
	programs = {
		nixvim = {
			enable = true;
			clipboard = {
				providers = {
					wl-copy = {
						enable = true;
					};
				};
			};
			colorschemes = {
				nord = {
					enable = true;
					lazyload = {
						enable = true;
					};
				};
			};
			keymaps = [
				{
					mode = [
						"n"
					];
					action = ":IncRename ";
					key = "<leader>rn";
					options = {
						silent = true;
					};
				}
			];
			plugins = {
				auto-save = {
					enable = true;
				};
				auto-close = {
					enable = true;
					keys = {
						"{" = { escape = false; close = true; pair = "{}"; };
						"[" = { escape = false; close = true; pair = "[]"; };
						"(" = { escape = false; close = true; pair = "()"; };
						"<" = { escape = false; close = true; pair = "<>"; };
						'"' = { escape = false; close = true; pair = '""'; };
						"'" = { escape = false; close = true; pair = "''"; };
						"`" = { escape = false; close = true; pair = "``"; };
					};
				};
				blink-cmp = {
					enable = true;
					settings = {
						"lsp"
						"snippets"
						"path"
						"buffer"
					};
				};
				comment = {
					enable = true;
					settings = {
						mappings = {
							basic = true;
							extra = false;
						};
						toggler = {
							block = "ccb";
							line = "ccl";
						};
						opleader = {
							block = "csb";
							line = "csl";
						};
					};
				};
				conform-nvim = {
					enable = true;
					settings = {
						formatters_by_ft = {
							bash = [
								"beautysh"
							];
							lua = [
								"stylua"
							];
							python = [
								"black"
							];
							javascript = [
								"prettierd";
							];
							typescript = [
								"prettierd";
							];
							javascriptreact = [
								"prettierd";
							];
							typescriptreact = [
								"prettierd";
							];
							css = [
								"prettierd";
							];
							scss = [
								"prettierd";
							];
							"*" = [
								"codespell"
							],
							"_" = [
								"squeeze_blanks"
								"trim_whitespace"
								"trim_newlines"
							];
						};
						format_on_save = {
							lsp_fallback = true;
							timeout_ms = 500;
						};
					};
				};
				inc-rename = {
					enable = true;
				};
				lsp = {
					enable = true;
					capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities);
					inlayHints = true;
					onAttach = function(client, bufnr)
        				local opts = {
        					noremap = true,
        					silent = true
        					buffer = bufnr
        				}
        				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.declaration, opts)
        				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					end,
					servers = {
						bashls = {
							enable = true;
						};
						lua_ls = {
							enable = true;
						};
						pyright = {
							enable = true;
						};
						cssls = {
							enable = true;
						};
						ts_ls = {
							enable = true;
						};
					};
				};
				lsp-lines = {
					enable = true;
				}; 
				lsp-signature = {
					enable = true;
				};
				lualine = {
					enable = true;
				};
				treesitter = {
					enable = true;
				};
			};
		};
	};
}