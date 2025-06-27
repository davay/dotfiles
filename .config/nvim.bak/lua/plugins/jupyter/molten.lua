-- Required Python packages: pynvim, jupyter_client, ipykernel
local is_kitty = os.getenv("KITTY_WINDOW_ID") ~= nil
local is_ghostty = os.getenv("GHOSTTY_BIN_DIR") ~= nil

local deps = {}
if is_kitty or is_ghostty then
  deps = { "3rd/image.nvim" }
end

return {
  {
    "benlubas/molten-nvim",
    dependencies = deps,
    ft = "markdown",
    build = ":UpdateRemotePlugins",
    init = function()
      -- I find auto open annoying, keep in mind setting this option will require setting
      -- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
      vim.g.molten_auto_open_output = false

      -- none or image.nvim or wezterm (install wezterm.nvim)
      -- if kitty/wezterm use image.nvim, otherwise dont load images
      if is_kitty or is_ghostty then
        vim.g.molten_image_provider = "image.nvim"
      else
        vim.g.molten_image_provider = "none"
      end

      -- optional, I like wrapping. works for virt text and the output window
      vim.g.molten_wrap_output = true

      -- Output as virtual text. Allows outputs to always be shown, works with images, but can
      -- be buggy with longer images
      vim.g.molten_virt_text_output = true

      -- this will make it so the output shows up below the \`\`\` cell delimiter
      vim.g.molten_virt_lines_off_by_1 = true

      -- different highlight for output border depending on state (running/done/err)
      vim.g.molten_use_border_highlights = true

      -- How quickly ui will update, default is 500, lower is snappier
      vim.g.molten_tick_rate = 250

      vim.g.molten_enter_output_behavior = "open_and_enter"

      vim.g.molten_virt_text_max_lines = 50

      -- Disable MoltenCell highlighting
      vim.api.nvim_set_hl(0, "MoltenCell", {})

      -- This is needed so vim.fn.MoltenAvailableKernels doesn't return blank
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.md", "*.ipynb" },
        callback = function()
          require("molten.status").initialized()
        end,
      })

      -- Autoinit molten & quarto
      -- tries to find a kernel that matches the kernel in the jupyter notebook
      -- falls back to a kernel that matches the name of the active venv (if any)
      local imb = function(e) -- init molten buffer
        vim.schedule(function()
          -- Ensure the file exists and is readable
          if not e.file or vim.fn.filereadable(e.file) ~= 1 then
            return
          end

          local kernels = vim.fn.MoltenAvailableKernels()

          local try_kernel_name = function()
            local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
            return metadata.kernelspec.name
          end
          local ok, kernel_name = pcall(try_kernel_name)
          if not ok or not vim.tbl_contains(kernels, kernel_name) then
            kernel_name = nil
            local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            if venv ~= nil then
              kernel_name = string.match(venv, "/.+/(.+)")
            end
          end
          if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
            pcall(function()
              vim.cmd(("MoltenInit %s"):format(kernel_name))
              vim.cmd("QuartoActivate")
            end)
          end

          -- Only import output if we're in a valid buffer with a file
          if vim.api.nvim_buf_is_valid(e.buf) and vim.fn.bufname(e.buf) ~= "" then
            pcall(function()
              vim.cmd("MoltenImportOutput")
            end)
          end
        end)
      end

      -- automatically import output chunks from a jupyter notebook
      vim.api.nvim_create_autocmd("BufAdd", {
        pattern = { "*.ipynb" },
        callback = function(e)
          -- Check if the buffer corresponds to a file
          if e.file and vim.fn.filereadable(e.file) == 1 then
            imb(e)
          end
        end,
      })

      -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.ipynb" },
        callback = function(e)
          -- Check if the buffer corresponds to a file
          if e.file and vim.fn.filereadable(e.file) == 1 and vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            imb(e)
          end
        end,
      })

      -- automatically export output chunks to a jupyter notebook on write
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.ipynb" },
        callback = function(e)
          -- Check if the buffer corresponds to a file
          if e.file and vim.fn.filereadable(e.file) == 1 then
            pcall(function()
              if require("molten.status").initialized() == "Molten" then
                vim.cmd("MoltenExportOutput!")
              end
            end)
          end
        end,
      })

      -- Provide a command to create a blank new Python notebook
      -- note: the metadata is needed for Jupytext to understand how to parse the notebook.
      -- if you use another language than Python, you should change it in the template.
      local default_notebook = [[
        {
          "cells": [
           {
            "cell_type": "markdown",
            "metadata": {},
            "source": [
              ""
            ]
           }
          ],
          "metadata": {
           "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
           },
           "language_info": {
            "codemirror_mode": {
              "name": "ipython"
            },
            "file_extension": ".py",
            "mimetype": "text/x-python",
            "name": "python",
            "nbconvert_exporter": "python",
            "pygments_lexer": "ipython3"
           }
          },
          "nbformat": 4,
          "nbformat_minor": 5
        }
      ]]

      local function new_notebook(filename)
        local path = filename .. ".ipynb"
        local file = io.open(path, "w")
        if file then
          file:write(default_notebook)
          file:close()
          vim.cmd("edit " .. path)
        else
          print("Error: Could not open new notebook file for writing.")
        end
      end

      vim.api.nvim_create_user_command('NewNotebook', function(opts)
        new_notebook(opts.args)
      end, {
        nargs = 1,
        complete = 'file'
      })
    end,
  },
}
