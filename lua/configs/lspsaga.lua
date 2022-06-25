local status_ok, lspsaga = pcall(require, "lspsage")
if not status_ok then
  return
end

lspsaga.setup({
  -- Error,Warn,Info,Hint
  -- use emoji
  -- like {'🙀','😿','😾','😺'}
  -- {'😡','😥','😤','😐'}
  diagnostic_header_icon = { " ", " ", " ", "ﴞ " },
  -- show diagnostic source
  show_diagnostic_source = true,
  -- add bracket or something with diagnostic source,just have 2 elements
  diagnostic_source_bracket = {},
  -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- code action title icon
  code_action_icon = "💡",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = { quit = "q", exec = "<CR>" },
  rename_action_keys = { quit = "<C-c>", exec = "<CR>" },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  rename_output_qflist = { enable = false, auto_open_qflist = false },
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
})

lspsaga.init_lsp_saga {

}

