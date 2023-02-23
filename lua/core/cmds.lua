local M = {}

local function open_nvim_tree(data)

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if no_name or not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end--- Load the default set of autogroups and autocommands.
function M.load_augroups()
	local user_config_file = require("lvim.config"):get_user_config_path()

	if vim.loop.os_uname().version:match("Windows") then
		-- autocmds require forward slashes even on windows
		user_config_file = user_config_file:gsub("\\", "/")
	end

	return {
		_general_settings = {
			{ "FileType", "qf,help,man", "nnoremap <silent> <buffer> q :close<CR>" },
			{
				"TextYankPost",
				"*",
				"lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
			},
			{
				"BufWinEnter",
				"dashboard",
				"setlocal cursorline signcolumn=yes cursorcolumn number",
			},
			{ "BufWritePost", user_config_file, "lua require('lvim.config'):reload()" },
			{ "FileType", "qf", "set nobuflisted" },
			-- { "VimLeavePre", "*", "set title set titleold=" },
		},
		_formatoptions = {
			{
				"BufWinEnter,BufRead,BufNewFile",
				"*",
				"setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
			},
		},
		_filetypechanges = {},
		_git = {
			{ "FileType", "gitcommit", "setlocal wrap" },
			{ "FileType", "gitcommit", "setlocal spell" },
		},
		_markdown = {
			{ "FileType", "markdown", "setlocal wrap" },
			{ "FileType", "markdown", "setlocal spell" },
		},
		_buffer_bindings = {
			{ "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
		},
		_auto_resize = {
			-- will cause split windows to be resized evenly if main window is resized
			{ "VimResized", "*", "tabdo wincmd =" },
		},
		_general_lsp = {
			{ "FileType", "lspinfo,lsp-installer,null-ls-info", "nnoremap <silent> <buffer> q :close<CR>" },
		},
		_cmp = {
			{ "FileType", "toml", "lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }" },
		},
		custom_groups = {},
	}
end

function M.toggle_format_on_save()
	local status, _ = pcall(vim.api.nvim_get_autocmds, {
		group = "lsp_format_on_save",
		event = "BufWritePre",
	})
	if not status then
		M.enable_format_on_save()
	else
		M.disable_format_on_save()
	end
end

function M.enable_transparent_mode()
	vim.cmd("au ColorScheme * hi Normal ctermbg=none guibg=none")
	vim.cmd("au ColorScheme * hi SignColumn ctermbg=none guibg=none")
	vim.cmd("au ColorScheme * hi NormalNC ctermbg=none guibg=none")
	vim.cmd("au ColorScheme * hi MsgArea ctermbg=none guibg=none")
	vim.cmd("au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none")
	vim.cmd("au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none")
	vim.cmd("au ColorScheme * hi EndOfBuffer ctermbg=none guibg=none")
	vim.cmd("let &fcs='eob: '")
end

--- Disable autocommand groups if it exists
--- This is more reliable than trying to delete the augroup itself
---@param name string the augroup name
function M.disable_augroup(name)
	-- defer the function in case the autocommand is still in-use
	vim.schedule(function()
		if vim.fn.exists("#" .. name) == 1 then
			vim.cmd("augroup " .. name)
			vim.cmd("autocmd!")
			vim.cmd("augroup END")
		end
	end)
end

--- Create autocommand groups based on the passed definitions
---@param definitions table contains trigger, pattern and text. The key will be used as a group name
function M.define_augroups(definitions, buffer)
	for group_name, definition in pairs(definitions) do
		vim.cmd("augroup " .. group_name)
		if buffer then
			vim.cmd([[autocmd! * <buffer>]])
		else
			vim.cmd([[autocmd!]])
		end

		for _, def in pairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.cmd(command)
		end

		vim.cmd("augroup END")
	end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

return M
