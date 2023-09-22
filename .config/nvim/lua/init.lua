local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

{
        "nvim-treesitter/nvim-treesitter",
},
{

        "nvim-lualine/lualine.nvim",
},

})

require("lualine").setup({
        dependencies = {
                "nvim-tree/nvim-web-devicons"
        },
        event = "VimEnter",
        options = {
                icons_enabled = true,
                theme = 'gruvbox',
                component_separators = "|",
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                }
        },
        sections = {
                lualine_a = {
                        { 'mode', seperator = { left = ''}, right_padding = 2 },
                },
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_w = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {
                        { 'location', seperator = { right = '' }, left_padding = 2 },
                },
        },
       inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' },
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}

})
