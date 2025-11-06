local map = LazyVim.safe_keymap_set
map({ "i" }, "<C-s>", "<C-o>:w<ENTER>")
map({ "n" }, "<C-s>", ":w<ENTER>")

vim.keymap.set("n", "<leader>e", function()
	local miniFiles = require("mini.files")
	miniFiles.open()
end, { desc = "Open File Browser" })
