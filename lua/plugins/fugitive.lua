return {
  'tpope/vim-fugitive',
  config = function()
    -- Fold the diff of commited files when browsing the git history
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'git',
      group = vim.api.nvim_create_augroup('fugitive_git_ft', { clear = true }),
      callback = function() vim.opt_local.foldmethod = 'syntax' end,
    })
  end,
}
