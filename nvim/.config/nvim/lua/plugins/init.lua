local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

return {
	{ "LazyVim/LazyVim", enabled = false },
	{ "EdenEast/nightfox.nvim", opts = { options = { terminal_colors = false } } },
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {
			default_mappings = false,
			mappings = {
				delete_line = "dm",
			},
		},
	},
	{
		"FabijanZulj/blame.nvim",
		lazy = false,
		config = function()
			require("blame").setup({})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		opts = function()
			local cmp = require("cmp")
			local types = require("cmp.types")
			return {
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = {
					{
						name = "nvim_lsp",
						entry_filter = function(entry)
							return entry:get_kind() ~= types.lsp.CompletionItemKind.Snippet
						end,
					},
					{ name = "buffer" },
					{ name = "path" },
				},
			}
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		config = function()
			require("trouble").setup({})
		end,
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{ "folke/snacks.nvim", opts = { input = { enabled = true }, picker = { enabled = true } } },
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
		},
		config = function()
			local util = require("lspconfig.util")
			vim.lsp.config("clangd", {
				cmd = { "clangd" },
			})
			vim.lsp.config("rust_analyzer", { cmd = { mason_bin .. "/rust-analyzer" } })
			vim.lsp.config("typescript-language-server", {
				cmd = { mason_bin .. "/typescript-language-server", "--stdio" },
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
			})
			vim.lsp.config("lua_ls", {
				cmd = {
					mason_bin .. "/lua-language-server",
				},
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			})
			vim.lsp.config("eslint-lsp", {
				cmd = { mason_bin .. "/vscode-eslint-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
				},
				root_dir = util.root_pattern(
					"eslint.config.js",
					"eslint.config.mjs",
					".eslintrc",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.json",
					"package.json"
				),
				settings = {
					format = false, -- let conform.nvim handle formatting
				},
			})

			vim.lsp.enable({
				"pyright",
				"jsonls",
				"clangd",
				"lua_ls",
				"rust_analyzer",
				"typescript-language-server",
				"eslint",
			})
		end,
	},
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				json = { "prettier" },
				lua = { "stylua" },
				html = { "prettier" },
				typescript = { "prettier", "eslint_d" },
				typescriptreact = { "prettier", "eslint_d" },
				css = { "prettier" },
				swift = { "swiftformat" },
			},
			format_after_save = { timeout_ms = 500, lsp_format = "fallback", async = true },
		},
	},
	{ "ibhagwan/fzf-lua", opts = { files = { path_shorten = 3 } } },
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"rust-analyzer",
				"lua-language-server",
				"clangd",
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
				"prettier",
				"typescript-language-server",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
}
