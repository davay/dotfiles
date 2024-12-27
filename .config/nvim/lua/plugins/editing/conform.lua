return {
  'stevearc/conform.nvim', -- really I just installed this for jupyter formatting
  config = function()
    require('conform').setup({
      default_format_opts = {
        timeout_ms = 1000,
        async = false,           -- not recommended to change
        quiet = false,           -- not recommended to change
        lsp_format = 'fallback', -- not recommended to change
      },

      format_on_save = function(bufnr)
        if vim.b[bufnr].disable_autoformat then
          return
        end
        return {} -- enables format_on_save with defaults
      end,

      vim.api.nvim_create_user_command("ToggleFormat", function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.b[bufnr].disable_autoformat = not vim.b[bufnr].disable_autoformat
        vim.notify("Conform: Format-on-save is " .. (vim.b[bufnr].disable_autoformat and "disabled" or "enabled"))
      end, {
        desc = "Toggle format-on-save",
      }),

      formatters_by_ft = {
        markdown = { 'injected' },
        python = {
          'ruff_format',
          'ruff_organize_imports',
        },
      },
      formatters = {
        injected = {
          ignore_errors = true,
        }
      }
    })

    -- Special case since jupytext creates autocmd for bufwritecmd and filewritecmd, bufwritepre doesn't get triggered.
    -- autocmd is ran in the order they're loaded in. Conform should always load first since it's set as a dependency, but check anyway, just in case.
    -- since I don't return anything before end, the next autocmd will be ran too
    if not package.loaded['jupytext'] then
      vim.api.nvim_create_autocmd({ 'BufWriteCmd', 'FileWriteCmd' },
        {
          pattern = '*.ipynb',
          callback = function()
            require('conform').format({ async = false })
          end,
        })
    else
      vim.notify('Jupytext already loaded - autocmd ordering may not be reliable')
    end
  end
}
