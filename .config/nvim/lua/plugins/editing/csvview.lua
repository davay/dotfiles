-- Doesn't have as many features as rainbow-csv, but works with filetype disabled
return {
  'hat0uma/csvview.nvim',
  ft = { 'csv', 'tsv' },
  config = function()
    require('csvview').setup()
  end
}