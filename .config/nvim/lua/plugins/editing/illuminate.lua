return {
  'RRethy/vim-illuminate',
  config = function()
    require('illuminate').configure({
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = {
        'lsp',
      },
    })
  end
}
