local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

return {
	{ "LazyVim/LazyVim", enabled = false },
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
	"folke/snacks.nvim",
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
		},
		config = function()
			vim.lsp.config("clangd", {
				cmd = { "clangd" },
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

			vim.lsp.enable({
				"pyright",
				"jsonls",
				"clangd",
				"lua_ls",
			})
		end,
	},
	{
		"CRAG666/betterTerm.nvim",
		keys = {
			{
				mode = { "n", "t" },
				"<C-;>",
				function()
					require("betterTerm").open()
				end,
				desc = "Open BetterTerm 0",
			},
			{
				mode = { "n", "t" },
				"<C-/>",
				function()
					require("betterTerm").open(1)
				end,
				desc = "Open BetterTerm 1",
			},
		},
		opts = {
			position = "bot",
			startInserted = true,
			size = 20,
			prefix = "Term",
			jump_tab_mapping = "<A-$tab>",
		},
	},
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				json = { "prettier" },
				lua = { "stylua" },
				html = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				swift = { "swiftformat" },
			},
			format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
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
