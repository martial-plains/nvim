local globals = {
    mapleader                  = ' ',
    maplocalleader             = ',',
    markdown_recommended_style = 0
}

for k, v in pairs(globals) do
    vim.g[k] = v
end

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
