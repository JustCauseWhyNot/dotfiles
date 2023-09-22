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

local function getWords()
        return vim.fn.wordcount().words
end

require("lualine").setup({
        dependencies = {
                "nvim-tree/nvim-web-devicons"
        },
        event = "VimEnter",
        options = {
                icons_enabled = true,
                theme = 'material',
                component_separators = { right = '', left = ''},
                section_separators = '|',
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
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype', getWords},
                lualine_y = {'progress'},
                lualine_z = {'location'},
        },
       inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}

})

