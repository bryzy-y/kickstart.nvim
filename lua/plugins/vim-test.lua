-- vim-test: run tests from inside Neovim
-- https://github.com/vim-test/vim-test

return {
  'vim-test/vim-test',
  cmd = { 'TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit' },
  init = function() vim.g['test#strategy'] = 'neovim' end,
}
