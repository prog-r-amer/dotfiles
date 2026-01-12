return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader><space>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find files",
		},
		{
			"<leader>f",
			function()
				require("telescope.builtin").lsp_document_symbols({
					symbols = { "Function", "Method", "Constructor" },
				})
			end,
			desc = "Find functions in file",
		},
		{
			"<leader>s",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Grep in files",
		},
	},
}
