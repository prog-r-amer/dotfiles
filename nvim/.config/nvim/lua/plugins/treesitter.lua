return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
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
	{

		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			---@type TSConfig
			require("nvim-treesitter.configs").setup({
				textobjects = {
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["<leader>w"] = "@argument.outer",
						},
						goto_previous_start = { ["<leader>q"] = "@argument.outer" },
					},
				},
			})
		end,
	},
}
