local base = require("plugins.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  on_attach = function (client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client,bufnr)
  end,
  capabilities = capabilities,
}

on_attach = function( bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end, opts)
    
  end
require("lspconfig").diagnosticls.setup {
  filetypes = {"python"},
  init_options = {
    formatters = {
      black = {
        command = "isort",
        args = {"--profle", "black", "--filter-files"},
      },
      formatFiletypes = {
        python = {"black"}
      }
    }
  }
}


lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

