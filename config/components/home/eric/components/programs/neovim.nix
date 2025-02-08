{
	pkgs,
	...
}: {
	programs = {
		neovim = {
			enable = true;
			defaultEditor = true;
			extraLuaConfig = ''
				vim.opt.number = true
				vim.opt.cursorline = true
				vim.opt.expandtab = true
				vim.opt.tabstop = 4
				vim.opt.shiftwidth = 4
				vim.opt.clipboard = "unnamedplus"
				vim.g.mapleader = " "
			'';
			extraPackages = with pkgs; [
				bash-language-server
				lua-language-server
				pyright
				typescript-language-server
				vscode-langservers-extracted
				beautysh
				stylua
				black
				prettierd
				codespell
			];
			plugins = with pkgs.vimPlugins; [
				{
					plugin = auto-save-nvim;
					config = ''
						require("auto-save").setup()
					'';
				}
				{
					plugin = blink-cmp;
					config = ''
						require("blink-cmp").setup({
							sources = {
								default = {
									"lsp",
									"snippets",
									"path",
									"buffer"
								}
							},
							keymap = {
								preset = "none",
								"<C-Up>" = {
									"select_prev"
								},
								"<C-Down>" = {
									"select_next"
								},
								"<C-Left>" = {
									"scroll_documentation_up"
								},
								"<C-Right>" = {
									"scroll_documentation_down"
								},
								"<C-m>" = {
									"show",
									"hide"
								},
								"<C-d>" = {
									"show_documentation",
									"hide_documentation"
								},
								"<C-CR>" = {
									"select_and_accept"
								}
							},
							appearance = {
								nerd_font_variant = "mono"
							},
							completion = {
								menu = {
									border = "rounded",
									draw = {
										gap = 2
									}
								},
								documentation = {
									auto_show = true,
									auto_show_delay_ms = 500,
									window = {
										border = "rounded"
									}
								}
							}
						})
					'';
				}
				{
					plugin = comment-nvim;
					config = ''
						require("Comment").setup({
							padding = true,
							mappings = {
								basic = true,
								extra = false
							},
							toggler = {
								line = "ccl",
								block = "ccb"
							},
							opleader = {
								line = "csl",
								block = "csb"
							}
						})
					'';
				}
				{
					plugin = conform-nvim;
					config = ''
						require("conform").setup({
							formatters_by_ft = {
								bash = {
									"beautysh"
								},
								lua = {
									"stylua"
								},
								python = {
									"black"
								},
								javascript = {
									"prettierd"
								},
								typescript = {
									"prettierd"
								},
								javascriptreact = {
									"prettierd"
								},
								typescriptreact = {
									"prettierd"
								},
								css = {
									"prettierd"
								},
								scss = {
									"prettierd"
								},
								["*"] = {
									"codespell"
								},
								["_"] = {
									"squeeze_blanks",
									"trim_whitespace",
									"trim_newlines"
								}
							},
							format_on_save = {
								timeout_ms = 500,
								lsp_fallback = true,
							}
						})
					'';
				}
				{
					plugin = hlchunk-nvim;
					config = ''
						require("hlchunk").setup({
							chunk = {
								enable = true
							},
							indent = {
								enable = true
							},
							line_num = {
								enable = true
							},
							blank = {
								enable = true
							}
						})
					'';
				}
				lsp_lines-nvim
				lsp_signature-nvim
				{
					plugin = nvim-lspconfig;
					config = ''
						local servers = {
							bashls = {},
							lua_ls = {},
							pyright = {},
							ts_ls = {},
							cssls = {}
						},
						for server, config in pairs(servers) do
							local lspconfig = require('lspconfig')
							config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
							config.on_attach = function(client, bufnr)
								local opts = {
									noremap = true,
									silent = true,
									buffer = bufnr
								}
								vim.keymap.set("n","gd", vim.lsp.buf.declaration, opts)
								vim.keymap.set({"n", "v"}, "ca", vim.lsp.buf.code_action, opts)
								vim.keymap.set("n","rn", vim.lsp.buf.rename, opts)
							end
							lspconfig[server].setup(config)
						end
						require("lsp_lines").setup()
						require "lsp_signature".setup({
							bind = true,
							handler_opts = {
								border = "rounded"
							}
						})
					'';
				}
				{
					plugin = lualine-nvim;
					config = ''
						require("lualine").setup({
							options = {
								globalstatus = true
							}
						})
					'';
				}
				{
					plugin = nvim-treesitter.withPlugins(parser: [
						parser.bash
						parser.lua
						parser.python
						parser.javascript
						parser.typescript
						parser.css
						parser.scss
					]);
					config = ''
						require("nvim-treesitter.configs").setup({
							auto_install = false,
							highlight = {
								enable = true
							}
						})
					'';
				}
				{
					plugin = tokyonight-nvim;
					config = ''
						require('tokyonight').setup({
							style = "storm",
							light_style = "day",
						})
						vim.cmd[[colorscheme tokyonight]]
					'';
				}
			];
		};
	};
}