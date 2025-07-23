return {
	"folke/which-key.nvim",
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
		},
		opts = {
			servers = {
				-- pyright will be automatically installed with mason and loaded with lspconfig
				pyright = {},
				lemminx = {},
				jsonls = {},
				clangd = {},
			},
		},
	},
	{ "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				json = { "prettier" },
				html = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				swift = { "swiftformat" },
			},
		},
	},
	{ "ibhagwan/fzf-lua", opts = { files = { path_shorten = 3 } } },
	{
		"williamboman/mason.nvim",
		version = "^1.0.0",
		opts = {
			ensure_installed = {
				"rust-analyzer",
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
				"prettier",
				"typescript-language-server",
			},
		},
	},
}
