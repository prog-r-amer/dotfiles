vim.api.nvim_create_autocmd("BufDelete", {
	group = vim.api.nvim_create_augroup("bufdelpost_autocmd", {}),
	desc = "BufDeletePost User autocmd",
	callback = function()
		vim.schedule(function()
			vim.api.nvim_exec_autocmds("User", {
				pattern = "BufDeletePost",
			})
		end)
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BufDeletePost",
	group = "bufdelpost_autocmd",
	callback = function()
		local dashboard = require("snacks.dashboard")
		local buffers = vim.tbl_filter(function(buf)
			if vim.api.nvim_buf_is_valid(buf) then
				local buf_info = vim.fn.getbufinfo(buf)[1]
				local buf_type = vim.bo.buftype[buf]
				return buf_type ~= "nofile" and buf_info.hidden ~= 1
			end
			return false
		end, vim.api.nvim_list_bufs())

		local buf_types = {}
		for _, v in pairs(buffers) do
			table.insert(buf_types, vim.fn.getbufinfo(v)[1])
		end
	end,
})
