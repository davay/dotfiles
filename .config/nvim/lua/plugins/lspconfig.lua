return {
  {
    "neovim/nvim-lspconfig",
    ft = { "markdown", "python" },
    opts = {
      servers = {
        sourcekit = {},
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
