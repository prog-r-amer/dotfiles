return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			local MiniFiles = require("mini.files")
			MiniFiles.setup({
				options = { use_as_default_explorer = true },
				mappings = {
					go_in = "<C-Right>",
					go_out = "<C-Left>",
					go_in_plus = "<CR>", -- open file or enter dir
					close = "q",
				},
			})
		end,
	},
}
