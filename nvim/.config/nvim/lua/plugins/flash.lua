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
	},
}
