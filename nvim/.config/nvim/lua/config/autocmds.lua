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
