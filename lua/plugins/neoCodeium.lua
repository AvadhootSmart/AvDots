return {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
        local neocodeium = require("neocodeium")
        neocodeium.setup(
        --     {
        --     bin = "/home/avadhoot/Downloads/language_server_linux_x64"
        -- }
        )
        vim.keymap.set("i", "<Tab>", neocodeium.accept)
    end,
}
