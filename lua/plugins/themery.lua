vim.api.nvim_set_keymap("n", "<leader>th", ":Themery<CR>", { noremap = true, silent = true })

return {
    {
        "zaldih/themery.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("themery").setup({
                themes = {
                    "tokyonight",
                    "catppuccin",
                    "nightfox",
                    "onedark",
                    "rose-pine",
                    "kanagawa-dragon",
                    "oh-lucy",
                    "tokyonight-night",
                    "tokyonight-storm",
                    "tokyonight-moon",
                    "tokyonight-day",
                    "tokyonight-storm",
                },
            })
        end,
    },
}
