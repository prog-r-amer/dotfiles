vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
	callback = function()
		vim.cmd(":set termguicolors")
		vim.cmd(":hi CursorICanSee guifg=#FFD9DA guibg=#FFD9DA")
		vim.cmd(":hi Cursor2 guifg=red guibg=red")
		vim.cmd(
			":set guicursor=n-v-c:block-CursorICanSee/CursorICanSee,i-ci-ve:ver50-Cursor2/lCursor2,r-cr:hor20,o:hor50"
		)
	end,
})
