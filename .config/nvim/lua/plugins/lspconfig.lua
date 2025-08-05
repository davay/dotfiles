return {
  {
    "neovim/nvim-lspconfig",
    ft = { "markdown", "python" },
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        sourcekit = {
          -- Enable file watching to automatically reload LSP when Package.swift or compile_commands.json changes
          -- Without this, LSP won't work after updating package manifest or adding new files until Neovim restart
          -- See: https://www.swift.org/documentation/articles/zero-to-swift-nvim.html
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
        },
        marksman = {
          on_attach = function(client, bufnr)
            -- Disable rename capability only when otter is active
            if vim.b[bufnr].otter_activated then
              client.server_capabilities.renameProvider = false
              client.server_capabilities.hoverProvider = false
            end
          end,
        },
      },
    },
  },
}
