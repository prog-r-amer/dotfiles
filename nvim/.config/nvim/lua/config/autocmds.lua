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

		vim.keymap.set("n", "gd", function()
			require("telescope.builtin").lsp_definitions()
		end, { buffer = args.buf, silent = true, desc = "Go to definition" })

		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = args.buf, silent = true, desc = "Rename" })

		if client.server_capabilities.documentHighlightProvider then
			client.server_capabilities.documentHighlightProvider = false
		end
	end,
})

vim.keymap.set("ca", "h", function()
	if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline():match("^h$") then
		return "tab help"
	end
	return "h"
end, { expr = true })

vim.keymap.set("ca", "help", function()
	if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline():match("^help$") then
		return "tab help"
	end
	return "help"
end, { expr = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.bo.buflisted = true
	end,
})
