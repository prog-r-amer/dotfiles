return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "ma",
					delete = "md",
				},
			})
			local MiniFiles = require("mini.files")
			vim.keymap.set("n", "<leader>e", function()
				if MiniFiles.get_explorer_state() ~= nil then
					MiniFiles.close()
				end
				local file = vim.api.nvim_buf_get_name(0)

				-- If no file is loaded (e.g. an empty buffer), fall back to CWD
				local dir
				if file == "" then
					dir = vim.uv.cwd()
				else
					dir = vim.fn.fnamemodify(file, ":p:h")
				end

				MiniFiles.open(dir, false)
			end, { desc = "File explorer" })
			MiniFiles.setup({
				options = { use_as_default_explorer = true },
				mappings = {
					go_in = "<C-Right>",
					go_out = "<C-Left>",
					go_in_plus = "<CR>", -- open file or enter dir
					close = "q",
				},
			})
		end,
	},
}
