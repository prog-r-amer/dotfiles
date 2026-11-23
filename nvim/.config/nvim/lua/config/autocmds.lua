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

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id

		vim.keymap.set("n", "<C-CR>", function()
			local fs_entry = MiniFiles.get_fs_entry()
			if fs_entry == nil or fs_entry.fs_type ~= "file" then
				return
			end

			-- Save the mini.files window ID before creating the tab
			local mf_win = vim.api.nvim_get_current_win()
			local new_target_win = vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
				vim.cmd("vsplit")
				return vim.api.nvim_get_current_win()
			end)

			-- Return focus to mini.files so go_in() knows which file is under the cursor
			vim.api.nvim_set_current_win(mf_win)

			-- Set the new tab's window as the target and open the file
			MiniFiles.set_target_window(new_target_win)
			MiniFiles.go_in({ close_on_file = true })
		end, { buffer = buf_id, desc = "Open file in new tab" })
	end,
})
