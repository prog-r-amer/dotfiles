local global = vim.g
local o = vim.o

vim.scriptencoding = "utf-8"
vim.opt.clipboard="unnamed,unnamedplus"
o.autoindent = true -- Copy indent from current line when starting a new line.
o.cursorline = true -- Highlight the screen line of the cursor with CursorLine.
o.expandtab = false
o.shiftwidth = 3
o.tabstop = 3 -- Number of spaces that a <Tab> in the file counts for.
o.encoding = "utf-8" -- Sets the character encoding used inside Vim.
o.fileencoding = "utf-8" -- Sets the character encoding for the file of this buffer.
o.background = "light"
