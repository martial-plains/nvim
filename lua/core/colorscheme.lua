local status_ok, theme = pcall(require, "dracula")
if not status_ok then
	return
end


vim.cmd("colorscheme nord")
