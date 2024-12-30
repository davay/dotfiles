return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  cond = function()
    return vim.bo.filetype == "latex"
  end,
  init = function()
    -- https://github.com/benbrastmckie/.config/blob/master/nvim/lua/neotex/plugins/vimtex.lua
    vim.g['vimtex_view_method'] = 'skim'        -- for variant without xdotool to avoid errors in wayland
    vim.g['vimtex_quickfix_mode'] = 0           -- suppress error reporting on save and build
    vim.g['vimtex_mappings_enabled'] = 0        -- Ignore mappings
    vim.g['vimtex_indent_enabled'] = 0          -- Auto Indent
    vim.g['tex_flavor'] = 'latex'               -- how to read tex files
    vim.g['tex_indent_items'] = 0               -- turn off enumerate indent
    vim.g['tex_indent_brace'] = 0               -- turn off brace indent
    vim.g['vimtex_context_pdf_viewer'] = 'skim' -- external PDF viewer run from vimtex menu command
    vim.g['vimtex_log_ignore'] = ({             -- Error suppression:
      'Underfull',
      'Overfull',
      'specifier changed to',
      'Token not allowed in a PDF string',
    })
  end
}
