return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({})

		-- <leader><space> to search for files in all subdirectories
		vim.keymap.set("n", "<leader><space>", builtin.find_files, {
			desc = "Find files",
		})
	end,
}
