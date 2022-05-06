local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
  return
end

return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true,
      },
      checkOnSave = {
        command = "clippy",
      },
      experimental = {
        procAttrMacros = true,
      },
    },
  },
}
