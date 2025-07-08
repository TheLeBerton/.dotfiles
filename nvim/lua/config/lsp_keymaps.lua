local M = {}

M.on_attach = function(client, bufnr)
  local bufmap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  bufmap("n", "gd", vim.lsp.buf.definition, "LSP Go to definition")
  bufmap("n", "gD", vim.lsp.buf.declaration, "LSP Go to declaration")
  bufmap("n", "gi", vim.lsp.buf.implementation, "LSP Go to implementation")
  bufmap("n", "gr", vim.lsp.buf.references, "LSP References")
  bufmap("n", "K", vim.lsp.buf.hover, "LSP Hover")
  bufmap("n", "<leader>rn", vim.lsp.buf.rename, "LSP Rename")
  bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "LSP Code action")
  bufmap("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, "LSP Format")
end

return M
