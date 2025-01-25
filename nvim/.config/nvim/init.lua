require("plugins").setup()
require("settings")
require("./config/mason-config")
require'lspconfig'.pyright.setup{}

vim.keymap.set({'i'}, '<C-s>', '<C-o>:w<ENTER>')
vim.keymap.set({'n'}, '<C-s>', ':w<ENTER>')
