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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		vim.keymap.set(
			"n",
			"<leader>la",
			vim.lsp.buf.code_action,
			{ buffer = args.buf, silent = true, desc = "LSP code action" }
		)

		vim.keymap.set("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end, { buffer = args.buf, silent = true, desc = "List references (Telescope)" })
		vim.keymap.set(
			"n",
			"gd",
			vim.lsp.buf.definition,
			{ buffer = args.buf, silent = true, desc = "Go to definition" }
		)
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = args.buf, silent = true, desc = "Rename" })

		if client.server_capabilities.documentHighlightProvider then
			client.server_capabilities.documentHighlightProvider = false
		end
	end,
})
