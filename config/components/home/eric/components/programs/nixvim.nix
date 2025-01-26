{
	pkgs,
	...
}: {
	programs = {
		nixvim = {
			enable = true;
			globals = {
				mapleader = " ";
			};
			opts = {
				number = true;
				cursorline = true;
				expandtab = true;
				tabstop = 4;
				shiftwidth = 4;
				clipboard = "unnamedplus";
			};
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
					lazyLoad = {
						enable = true;
						settings = {
							event = [
								"InsertLeave"
								"TextChanged"
							];
						};
					};
				};
				blink-cmp = {
					enable = true;
					lazyLoad = {
						enable = true;
						settings = {
							event = [
								"InsertEnter"
							];
						};
					};
					settings = {
						sources = {
							default = [
								"lsp"
								"snippets"
								"path"
								"buffer"
							];
						};
						providers = {
							ripgrep = {
								name = "Ripgrep";
								module = "blink-ripgrep";
								score_offset = 1;
							};
						};
						signature = {
							enabled = true;
						};
						keymap = {
							"<C-Up>" = [
								"select_prev"
							];
							"<C-Down>" = [
								"select_next"
							];
							"<C-Left>" = [
								"scroll_documentation_up"
							];
							"<C-Right>" = [
								"scroll_documentation_down"
							];
							"<C-m>" = [
								"show"
								"hide"
							];
							"<C-d>" = [
								"show_documentation"
								"hide_documentation"
							];
							"<C-CR>" = [
								"select_and_accept"
							];
						};
						appearance = {
							nerd_font_variant = "mono";
						};
						completion = {
							menu = {
								border = "rounded";
								draw = {
									gap = 2;
								};
							};
							documentation = {
								auto_show = true;
								auto_show_delay_ms = 300;
								window = {
									border = "rounded";
								};
							};
						};
					};
				};
				comment = {
					enable = true;
					lazyLoad = {
						enable = true;
						settings = {
							event = [
								"BufEnter"
							];
						};
					};
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
					lazyLoad = {
						enable = true;
						settings = {
							event = [
								"InsertLeave"
								"TextChanged"
							];
						};
					};
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
								"prettierd"
							];
							typescript = [
								"prettierd"
							];
							javascriptreact = [
								"prettierd"
							];
							typescriptreact = [
								"prettierd"
							];
							css = [
								"prettierd"
							];
							scss = [
								"prettierd"
							];
							"*" = [
								"codespell"
							];
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
				lsp = {
					enable = true;
					lazyLoad = {
						enable = true;
						settings = {
							event = [
								"BufReadPre"
								"BufNewFile"
							];
						};
					};
					capabilities = ''capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())'';
					inlayHints = true;
					keymaps = {
						silent = true;
						lspBuf = {
							"<leader>gr" = "references";
							"<leader>gd" = "definition";
							"<leader>gi" = "implementation";
							"<leader>gt" = "type_definition";
							"<leader>hc" = "hover";
							"<leader>rc" = "rename";
						};
					};
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
					lazyLoad = {
						enable = true;
						settings = {
							event = [
								"LspAttach"
							];
						};
					};
				}; 
				lsp-signature = {
					enable = true;
					lazyLoad = {
						enable = true;
						settings = {
							event = [
								"LspAttach"
							];
						};
					};
				};
				lualine = {
					enable = true;
					lazyLoad = {
						enable = true;
						settings = {
							event = [
								"VimEnter"
							];
						};
					};
					settings = {
						globalstatus = true;
					};
				};
				lz-n = {
					enable = true;
				};
				treesitter = {
					enable = true;
					lazyLoad = {
						enable = true;
						settings = {
							event = [
								"BufRead"
							];
						};
					};
				};
			};
			extraPlugins = with pkgs.vimPlugins; [
				blink-ripgrep-nvim
			];
		};
	};
}