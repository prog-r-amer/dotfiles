local map = LazyVim.safe_keymap_set
map({"i"}, "<C-s>", "<C-o>:w<ENTER>")
map({"n"}, "<C-s>", ":w<ENTER>")
