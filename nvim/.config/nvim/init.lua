vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.lazyvim_check_order = false
vim.o.expandtab = false
vim.o.scrolloff = 8
vim.o.tabstop = 3
vim.o.shiftwidth = 3
vim.o.autoindent = true
vim.opt.number = true
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.opt.ignorecase = true
vim.opt.smartcase = true

require("config.lazy_plain")
require("config.autocmds")
require("config.keys")

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

vim.cmd.colorscheme("dawnfox")
vim.opt.background = "light"
vim.cmd(":hi CursorICanSee guifg=#FFD9DA guibg=#FFD9DA")
vim.cmd(":hi Cursor2 guifg=red guibg=red")
vim.cmd(":set guicursor=n-v-c:block-CursorICanSee/CursorICanSee,i-ci-ve:ver50-Cursor2/lCursor2,r-cr:hor20,o:hor50")

vim.api.nvim_set_hl(0, "FlashChar", { link = "Search" })
vim.api.nvim_set_hl(0, "MarkSignHL", { fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "MarkSignNumHL", { link = "LineNr" })
