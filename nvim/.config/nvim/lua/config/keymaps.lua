local map = LazyVim.safe_keymap_set
map({ "i" }, "<C-s>", "<C-o>:w<ENTER>")
map({ "n" }, "<C-s>", ":w<ENTER>")
require("telescope").load_extension("file_browser")

vim.keymap.set("n", "<leader>e", function()
	require("telescope").extensions.file_browser.file_browser({
		path = "%:p:h", -- open in current file’s directory
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end, { desc = "Open File Browser" })
