return {
  "neovim/nvim-lspconfig",
  event = "User FilePost",
  config = function()
    -- Define on_attach and capabilities inside the function
    local utils = require("nvchad.utils") -- Replace with actual utils module if needed

--    local on_attach = function(client, bufnr)
 --     utils.load_mappings("lspconfig", { buffer = bufnr })
      -- Uncomment if needed
      -- if client.server_capabilities.signatureHelpProvider then
      --   require("nvchad.signature").setup(client)
      -- end
--    end

--    local on_init = function(client, _)
--      if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
--        client.server_capabilities.semanticTokensProvider = nil
--      end
--    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    -- Example configuration for lua_ls
    require("lspconfig").lua_ls.setup {
      on_init = on_init,
      on_attach = on_attach,
      capabilities = capabilities,

      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    }
  end,
}
