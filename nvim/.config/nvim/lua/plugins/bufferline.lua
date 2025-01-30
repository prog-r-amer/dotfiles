return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				always_show_bufferline = true,
				show_buffer_icons = false,
				show_buffer_close_icons = false,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						separator = true,
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},
}
