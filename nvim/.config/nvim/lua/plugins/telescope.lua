return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader><space>",
			function()
				require("telescope.builtin").find_files({ hidden = true })
			end,
			desc = "Find files",
		},
		{
			"<leader>f",
			function()
				require("telescope.builtin").lsp_document_symbols({
					symbols = { "Function", "Method", "Constructor" },
				})
			end,
			desc = "Find functions in file",
		},
		{
			"<leader>mm",
			function()
				local pickers = require("telescope.pickers")
				local finders = require("telescope.finders")
				local conf = require("telescope.config").values

				local marks = vim.fn.getmarklist()
				vim.list_extend(marks, vim.fn.getmarklist(vim.api.nvim_get_current_buf()))
				local filtered_marks = {}

				for _, m in ipairs(marks) do
					local name = m.mark:sub(2, 2)
					-- Only include letter marks (A-Z)
					if name:match("%a") then
						-- Resolve the filename
						local fname = vim.api.nvim_buf_get_name(m.pos[1])
						if fname == "" then
							fname = m.file
						end

						table.insert(filtered_marks, {
							mark = name,
							lnum = m.pos[2],
							col = m.pos[3],
							filename = fname,
						})
					end
				end

				pickers
					.new({}, {
						prompt_title = "All my marks",
						finder = finders.new_table({
							results = filtered_marks,
							entry_maker = function(entry)
								return {
									value = entry,
									-- This is what shows up in the list
									display = string.format(
										"%s  %s:%d",
										entry.mark,
										vim.fn.fnamemodify(entry.filename, ":t"),
										entry.lnum
									),
									-- This is what you can type to filter
									ordinal = entry.mark .. " " .. entry.filename,
									-- Coordinates for the previewer and jump
									filename = entry.filename,
									lnum = entry.lnum,
									col = entry.col,
								}
							end,
						}),
						sorter = conf.generic_sorter({}),
						previewer = conf.grep_previewer({}),
					})
					:find()
			end,
			desc = "Global Alpha Marks",
		},
		{
			"<leader>s",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Grep in files",
		},
	},
}
