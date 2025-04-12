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
			},
		},
	},
	{ "ibhagwan/fzf-lua", opts = { files = { path_shorten = 3 } } },
	{
		"williamboman/mason.nvim",
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
