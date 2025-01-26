return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {"nvim-tree/nvim-web-devicons"},
    keys = {
        {
            "<C-3>", function()
                local api = require("nvim-tree.api")
                local node = api.tree.get_node_under_cursor()
                api.tree.expand_all(node)
            end
        }
    },
    config = function()
        local function on_attach_change(bufnr)
            local api = require("nvim-tree.api")
            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true
                }
            end
            api.config.mappings.default_on_attach(bufnr)
            vim.keymap.set("n", "<C-P>",
                           function()
                api.tree.toggle({file_path = true})
            end, opts("Toggle nvimtree"))
        end

        require("nvim-tree").setup({
            on_attach = on_attach_change,
            renderer = {group_empty = true}
        })
    end
}
