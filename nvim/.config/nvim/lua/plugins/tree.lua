return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<C-1>",
			function()
				local api = require("nvim-tree.api")
				api.tree.open()
			end,
		},
		{
			"<C-2>",
			function()
				local api = require("nvim-tree.api")
				local node = api.tree.get_node_under_cursor()
				api.tree.expand_all(node)
			end,
		},
		{
			"<C-3>",
			function()
				local api = require("nvim-tree.api")
				api.tree.toggle({ file_path = true })
			end,
		},
	},
	config = function()
		local function on_attach_change(bufnr)
			local api = require("nvim-tree.api")
			api.config.mappings.default_on_attach(bufnr)
		end

		require("nvim-tree").setup({
			on_attach = on_attach_change,
			view = { width = 45 },
			renderer = { group_empty = true },
		})
	end,
}
