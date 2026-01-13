vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.lazyvim_check_order = false
vim.o.expandtab = false
vim.o.tabstop = 3
vim.o.shiftwidth = 3
vim.o.autoindent = true
vim.opt.number = true
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>d", function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = false })
		end
	end
end, { desc = "Close other buffers" })
require("config.lazy_plain")
require("config.autocmds")

local function toggle_line_numbers()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = false
		vim.wo.number = true
	else
		vim.wo.relativenumber = true
		vim.wo.number = true
	end
end

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.keymap.set(
	"n",
	"<leader><",
	toggle_line_numbers,
	{ noremap = true, silent = true, desc = "Toggle absolute/relative line numbers" }
)

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	signs = false,
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, {
			scope = "cursor",
			focus = false,
		})
	end,
})

local function get_everforest_dark_term_colors()
	-- Temporarily set dark background
	vim.o.background = "dark"
	vim.cmd.colorscheme("everforest")

	local term_colors = {}
	for i = 0, 15 do
		term_colors[i] = vim.g["terminal_color_" .. i]
	end

	return term_colors
end

_G.everforest_dark_term_colors = get_everforest_dark_term_colors()

vim.o.background = "light"
vim.cmd.colorscheme("everforest")

-- Apply dark terminal colors only for terminal usage
for i = 0, 15 do
	vim.g["terminal_color_" .. i] = _G.everforest_dark_term_colors[i]
end

vim.cmd(":set termguicolors")
vim.cmd(":hi CursorICanSee guifg=#FFD9DA guibg=#FFD9DA")
vim.cmd(":hi Cursor2 guifg=red guibg=red")
vim.cmd(":set guicursor=n-v-c:block-CursorICanSee/CursorICanSee,i-ci-ve:ver50-Cursor2/lCursor2,r-cr:hor20,o:hor50")
