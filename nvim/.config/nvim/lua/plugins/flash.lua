return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"s",
			mode = { "n" },
			function()
				require("flash").jump({ highlight = { backdrop = true } })
			end,
			desc = "Toggle Flash Search",
		},
		{
			"S",
			mode = { "n" },
			function()
				require("flash").treesitter()
			end,
			desc = "Toggle Flash Search",
		},
	},
}
