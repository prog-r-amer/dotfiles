vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-r>", "^", { noremap = true, silent = true })

local function toggle_line_numbers()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = false
		vim.wo.number = true
	else
		vim.wo.relativenumber = true
		vim.wo.number = true
	end
end

vim.keymap.set("n", "<leader>qo", function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype ~= "terminal" then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, { desc = "Close other buffers" })

vim.keymap.set("n", "<leader>qd", function()
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_delete(buf, { force = false })
end, { desc = "Delete buffer" })

vim.keymap.set("n", "<leader>c", "ci{", { desc = "Change in {" })

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.keymap.set(
	"n",
	"<leader><",
	toggle_line_numbers,
	{ noremap = true, silent = true, desc = "Toggle absolute/relative line numbers" }
)
