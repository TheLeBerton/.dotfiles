local lspconfig = require("lspconfig")

return function(on_attach, capabilities)
  lspconfig.clangd.setup({
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
