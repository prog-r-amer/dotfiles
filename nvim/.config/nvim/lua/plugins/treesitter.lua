return {
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
}
