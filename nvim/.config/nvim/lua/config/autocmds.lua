local function set_term_dark_bg()
	local buf = vim.api.nvim_get_current_buf()
	if vim.bo[buf].buftype ~= "terminal" then
		return
	end

	local ns = vim.api.nvim_create_namespace("TermDarkBG")
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_hl_ns(win, ns)

	vim.api.nvim_set_hl(ns, "Normal", { bg = "#000000" })
	vim.api.nvim_set_hl(ns, "NormalNC", { bg = "#000000" })
	vim.api.nvim_set_hl(ns, "EndOfBuffer", { bg = "#000000" })
end

-- Apply when a terminal is created
vim.api.nvim_create_autocmd("TermOpen", {
	callback = set_term_dark_bg,
})

-- Also apply when switching *into* a terminal window
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = set_term_dark_bg,
})
