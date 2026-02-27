return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "folke/lazydev.nvim",
    },
    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")

        -- 1. Setup Fidget (UI for LSP progress)
        require("fidget").setup({})

        -- 2. Setup LazyDev (Modern replacement for manual Lua library paths)
        require("lazydev").setup({})

        -- 3. Capabilities for Autocompletion
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())

        -- 4. Keymaps (Modern LspAttach Autocmd)
        -- This replaces the need to pass 'on_attach' to every single server.
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { noremap = true, silent = true, buffer = ev.buf }
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            end,
        })

        -- 5. Mason Setup
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
                "clangd",
                "vtsls",
                "tailwindcss",
                "solidity_ls",
            },
            handlers = {
                -- Default handler using the NEW Neovim 0.11 API
                function(server_name)
                    vim.lsp.config(server_name, {
                        capabilities = capabilities,
                    })
                    vim.lsp.enable(server_name)
                end,

                -- Specific override for Lua
                ["lua_ls"] = function()
                    vim.lsp.config("lua_ls", {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                            },
                        },
                    })
                    vim.lsp.enable("lua_ls")
                end,
            },
        })

        -- 6. nvim-cmp Setup (Completion Engine)
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "lazydev", group_index = 0 },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer" },
            }),
        })

        -- 7. Diagnostics UI
        vim.diagnostic.config({
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                border = "rounded",
                source = "always",
            },
        })
    end,
}
