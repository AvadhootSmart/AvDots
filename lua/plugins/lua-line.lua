local function update_lualine()
    local themery = require("themery")
    local current_theme = themery.get_current_theme()
    require("lualine").setup({
        options = {
            theme = current_theme,
            section_separators = "",
            component_separators = "",
        },
    })
end

vim.api.nvim_create_autocmd("User", {
    pattern = "ThemeryApplied",
    callback = update_lualine,
})
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto",
                section_separators = "",
                component_separators = "",
            },
        })
    end,
}
