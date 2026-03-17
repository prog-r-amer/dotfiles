return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			local move = require("nvim-treesitter-textobjects.move")

			vim.keymap.set("n", "<leader>w", function()
				move.goto_next_start("@argument.outer")
			end)

			vim.keymap.set("n", "<leader>b", function()
				move.goto_previous_start("@argument.outer")
			end)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					if vim.bo[ev.buf].buftype ~= "" then
						return
					end
					pcall(vim.treesitter.start, ev.buf)
				end,
			})
		end,
	},
}
