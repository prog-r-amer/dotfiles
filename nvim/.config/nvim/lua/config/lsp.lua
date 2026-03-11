local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

vim.lsp.config("clangd", {
	cmd = { "clangd" },
})

vim.lsp.config("rust_analyzer", { cmd = { mason_bin .. "/rust-analyzer" } })

vim.lsp.config("denols", {
	cmd = { "deno", "lsp" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_markers = { "deno.json", "deno.jsonc" },
	settings = {
		deno = {
			enable = true,
		},
	},
})

vim.lsp.config("tinymist", {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = { format = false, semanticTokens = "disable" },
})

vim.lsp.config("typescript-language-server", {
	cmd = { mason_bin .. "/typescript-language-server", "--stdio" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
	root_dir = function(bufnr, on_dir)
		if vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then
			return
		end
		on_dir(vim.fs.root(bufnr, { "package.json", "tsconfig.json", "jsconfig.json" }))
	end,
})

vim.lsp.config("lua_ls", {
	cmd = {
		mason_bin .. "/lua-language-server",
	},
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

vim.lsp.config("eslint-lsp", {
	cmd = { mason_bin .. "/vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},
	root_marker = {
		"eslint.config.js",
		"eslint.config.mjs",
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		"package.json",
	},
	settings = {
		format = false, -- let conform.nvim handle formatting
	},
})

vim.lsp.enable({
	"pyright",
	"jsonls",
	"clangd",
	"lua_ls",
	"rust_analyzer",
	"typescript-language-server",
	"denols",
	"eslint",
})
