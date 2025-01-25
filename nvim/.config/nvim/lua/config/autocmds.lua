vim.api.nvim_create_autocmd({ "SessionLoadPost", "UIEnter" }, {
	group = vim.api.nvim_create_augroup("UIEnter", { clear = true }),
	desc = "Open neo-tree on UIEnter",
	callback = function()
		vim.cmd("Neotree")
	end,
})
