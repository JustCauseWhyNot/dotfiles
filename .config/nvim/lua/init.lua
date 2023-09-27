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
        build = ":TSUpdate",
        lazy = false,
        event = "VimEnter",
        config = function()
                local configs = require("nvim-treesitter.configs")

                configs.setup({
                        ensure_installed = { "c", "lua", "vim", "vimdoc", "python" },
                        sync_install = false,
                        highlight = { enable = true},
                        indent = { enable = true},
                })
        end
},

{

        "nvim-lualine/lualine.nvim",
},

{
        "lukas-reineke/indent-blankline.nvim"
},


{
        'projekt0n/github-nvim-theme',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
                require('github-theme').setup({
                -- ...
                })

        vim.cmd('colorscheme github_dark_colorblind')
        end,
},

{
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = { 
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                },
        config = function()
        require'cmp'.setup {
        snippet = {
                expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
                        end
                        },

                }
        end,


},

{
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = {
                'rafamadriz/friendly-snippets',
                'saadparwaiz1/cmp_luasnip',
                },
},

})

require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

require("cmp").setup({
        snippet = {
        expand = function(args)
            local luasnip = prequire("luasnip")
            if not luasnip then
                return
            end
            luasnip.lsp_expand(args.body)
        end,
        },

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),

    sources = cmp.config.sources({
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
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

require('github-theme').compile() -- lua api version

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}
