return {
	"akinsho/toggleterm.nvim",
	keys = {
		{ [[<C-\>]] },
		{ "<leader>t1", "<Cmd>1ToggleTerm<Cr>", desc = "Terminal #1" },
		{ "<leader>t2", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
		{ "<leader>t3", "<Cmd>3ToggleTerm<Cr>", desc = "Terminal #3" },
		{ "<leader>t4", "<Cmd>4ToggleTerm<Cr>", desc = "Terminal #4" },
		{ "<leader>tf", "<Cmd>ToggleTerm direction=float<Cr>", desc = "Float" },
		{ "<leader>th", "<Cmd>ToggleTerm size=20 direction=horizontal<Cr>", desc = "Horizontal" },
		{ "<leader>tv", "<Cmd>ToggleTerm size=80 direction=vertical<Cr>", desc = "Vertical" },
		{ "<leader>tt", "<Cmd>ToggleTerm direction=tab<Cr>", desc = "Tab" },
	},
	cmd = { "ToggleTerm", "TermExec" },
	opts = {
		size = 20,
		hide_numbers = true,
		open_mapping = [[<C-\>]],
		shade_filetypes = {},
		shade_terminals = false,
		shading_factor = 0.3,
		start_in_insert = true,
		persist_size = true,
		direction = "float",
		winbar = {
			enabled = false,
			name_formatter = function(term)
				return term.name
			end,
		},
	},
}
