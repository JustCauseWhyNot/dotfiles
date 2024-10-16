local function getWords()
	return vim.fn.wordcount().words
end

return {
	'nvim-lualine/lualine.nvim', 
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
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
}
