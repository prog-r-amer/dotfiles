return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
			callback = function(ev)
				local ft = vim.bo[ev.buf].filetype
				if ft == "" then
					return
				end

				local lang = vim.treesitter.language.get_lang(ft)
				if not lang then
					return
				end

				vim.treesitter.start(ev.buf, lang)
			end,
		})
	end,
}
