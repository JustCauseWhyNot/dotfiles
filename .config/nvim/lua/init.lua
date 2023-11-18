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
        "lukas-reineke/indent-blankline.nvim",
                main = "ibl",
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
        'neovim/nvim-lspconfig',
                dependencies = {
                        'hrsh7th/cmp-nvim-lsp',
                        'hrsh7th/cmp-buffer',
                        'hrsh7th/cmp-path',
                        'hrsh7th/cmp-cmdline',
                        'hrsh7th/nvim-cmp',
                        'L3MON4D3/LuaSnip',
                        'saadparwaiz1/cmp_luasnip',
                        'rafarmadriz/friendly-snippets',
                },

},
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
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

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      --completion = cmp.config.window.bordered(),
      --documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
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

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
  }
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({

  -- ... Your other configuration ...

  mapping = {
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
      -- that way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
})

require('github-theme').compile() -- lua api version
require('luasnip.loaders.from_vscode').lazy_load()
