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
				jsonls = {},
				clangd = { mason = false, cmd = { "clangd" } },
			},
		},
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
			{
				"<leader>tt",
				function()
					require("betterTerm").select()
				end,
				desc = "Select terminal",
			},
		},
		opts = {
			position = "bot",
			size = 20,
			jump_tab_mapping = "<A-$tab>",
		},
	},
	{ "mason-org/mason-lspconfig.nvim" },
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
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"rust-analyzer",
				"clangd",
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
				"prettier",
				"typescript-language-server",
			},
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
}
