return {
	"folke/which-key.nvim",
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		dependencies = { { "folke/neoconf.nvim", cmd = "Neoconf", config = true } },
		opts = {
			---@type lspconfig.options
			servers = {
				-- pyright will be automatically installed with mason and loaded with lspconfig
				pyright = {},
				lemminx = {},
				jsonls = {},
			},
		},
	},
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/typescript.nvim",
			init = function()
				require("lazyvim.util").lsp.on_attach(function(_, buffer)
                    -- stylua: ignore
                    vim.keymap.set("n", "<leader>co",
                                   "TypescriptOrganizeImports",
                                   {buffer = buffer, desc = "Organize Imports"})
					vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
				end)
			end,
		},
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- tsserver will be automatically installed with mason and loaded with lspconfig
				tsserver = {},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				tsserver = function(_, opts)
					require("typescript").setup({ server = opts })
					return true
				end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
	},
	{ "stevearc/conform.nvim", opts = { formatters_by_ft = { json = { "prettier" } } } },
	{ "ibhagwan/fzf-lua", opts = { files = { path_shorten = 3 } } },
	{
		"williamboman/mason.nvim",
		opts = { ensure_installed = { "stylua", "shellcheck", "shfmt", "flake8", "prettier" } },
	},
}
