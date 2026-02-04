return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		direction = "float",
		shade_terminals = false,
		float_opts = {
			winblend = 0,
			border = "double",
		},
	},
	config = function(_, opts)
		local term_colors = {
			"#282828",
			"#ee5396",
			"#25be6a",
			"#08bdba",
			"#78a9ff",
			"#be95ff",
			"#33b1ff",
			"#dfdfe0",
			"#484848",
			"#f16da6",
			"#46c880",
			"#2dc7c4",
			"#8cb6ff",
			"#c8a5ff",
			"#52bdff",
			"#ffffff",
		}
		local function apply_carbon_highlights()
			vim.api.nvim_set_hl(0, "CarbonTermNormal", { fg = "#f2f4f8", bg = "#161616" })
			vim.api.nvim_set_hl(0, "CarbonTermBorder", { fg = "#7b7c7e", bg = "#161616" })
		end
		apply_carbon_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = apply_carbon_highlights,
		})

		opts.on_open = function(term)
			for i, color in ipairs(term_colors) do
				vim.g["terminal_color_" .. (i - 1)] = color
			end
			vim.api.nvim_set_option_value(
				"winhighlight",
				"Normal:CarbonTermNormal,NormalFloat:CarbonTermNormal,FloatBorder:CarbonTermBorder",
				{ scope = "local", win = term.window }
			)
			vim.schedule(function()
				if vim.api.nvim_buf_is_valid(term.bufnr) then
					vim.cmd("startinsert!")
				end
			end)
		end
		require("toggleterm").setup(opts)
		vim.keymap.set("t", "<C-t>", [[<C-\><C-n><cmd>ToggleTerm<CR>]], { noremap = true, silent = true })
		vim.keymap.set("n", "<C-t>", [[<cmd>ToggleTerm<CR>]], { noremap = true, silent = true })
		vim.api.nvim_set_hl(0, "CarbonTermNormal", { fg = "#f2f4f8", bg = "#161616" })
		vim.api.nvim_set_hl(0, "CarbonTermBorder", { fg = "#7b7c7e", bg = "#161616" })
	end,
}
