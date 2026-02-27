return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Load on save for format-on-save
    cmd = { "ConformInfo" },
    keys = {
        {
            "F", -- Your preferred keybind
            function()
                require("conform").format({ async = true, lsp_fallback = true }, function(err)
                    if not err then
                        vim.notify("Formatted", vim.log.levels.INFO, { title = "Conform" })
                    end
                end)
            end,
            mode = "n",
            desc = "Format buffer",
        },
    },
    opts = {
        notify_on_error = true,
        notify_no_formatters = true,
        formatters_by_ft = {
            -- Use a sub-list to run multiple formatters in order
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            lua = { "stylua" },
            -- Use 'stop_after_first' to pick the first one available
            python = { "ruff_format", "black", stop_after_first = true },
            -- Go usually uses lsp_fallback (gopls), but you can specify
            go = { "goimports", "gofmt" },
        },
        -- Enable format on save
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
}
