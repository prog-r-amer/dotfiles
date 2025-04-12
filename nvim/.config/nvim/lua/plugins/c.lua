return {
	{
		"mfussenegger/nvim-dap",
		optional = true,
		config = function(_)
			local dap = require("dap")

			dap.adapters.gdb = {
				id = "gdb",
				type = "executable",
				command = "gdb",
				args = { "--quiet", "--interpreter=dap" },
			}

			dap.configurations.c = {
				{
					name = "Run executable (GDB)",
					type = "gdb",
					request = "launch",
					program = function()
						local path = vim.fn.input({
							prompt = "Path to executable: ",
							default = vim.fn.getcwd() .. "/",
							completion = "file",
						})
						return (path and path ~= "") and path or dap.ABORT
					end,
				},
				{
					name = "Run executable with arguments (GDB)",
					type = "gdb",
					request = "launch",
					program = function()
						local path = vim.fn.input({
							prompt = "Path to executable: ",
							default = vim.fn.getcwd() .. "/",
							completion = "file",
						})
						return (path and path ~= "") and path or dap.ABORT
					end,
					args = function()
						local args_str = vim.fn.input({
							prompt = "Arguments: ",
						})
						return vim.split(args_str, " +")
					end,
				},
				{
					name = "Attach to process (GDB)",
					type = "gdb",
					request = "attach",
					processId = require("dap.utils").pick_process,
				},
			}

			-- You can add configurations for C++ if needed
			dap.configurations.cpp = dap.configurations.c
		end,
	},
}
