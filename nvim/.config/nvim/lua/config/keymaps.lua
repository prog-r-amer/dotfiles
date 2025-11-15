local map = LazyVim.safe_keymap_set
map({ "i" }, "<C-s>", "<C-o>:w<ENTER>")
map({ "n" }, "<C-s>", ":w<ENTER>")

vim.keymap.set("n", "<leader>e", function()
	local MiniFiles = require("mini.files")
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
end, { desc = "Open File Browser" })
