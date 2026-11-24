local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

vim.lsp.config("clangd", {
	cmd = { "clangd" },
})

vim.lsp.config("rust_analyzer", { cmd = { mason_bin .. "/rust-analyzer" } })

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

local oxlint_markers = {
	".oxlintrc.json",
	".oxlintrc.jsonc",
	"oxlint.config.ts",
	"oxlint.config.mjs",
	"oxlint.config.js",
}

vim.lsp.config("oxlint-lsp", {
	cmd = { mason_bin .. "/oxlint-lsp" },
	root_markers = oxlint_markers,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},
})

vim.lsp.config("eslint-lsp", {
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		if fname == "" then
			return
		end

		-- Skip ESLint if this project uses Oxlint
		if vim.fs.root(fname, oxlint_markers) then
			return
		end

		local root = vim.fs.root(fname, {
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			"eslint.config.ts",
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			"package.json",
		})

		if root then
			on_dir(root)
		end
	end,
})

vim.lsp.enable({
	"pyright",
	"jsonls",
	"clangd",
	"lua_ls",
	"rust_analyzer",
	"typescript-language-server",
	"eslint",
	"oxlint",
	"oxfmt",
})
