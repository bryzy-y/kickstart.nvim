-- aerial.nvim: code outline / symbol tree
-- https://github.com/stevearc/aerial.nvim

return {
  'stevearc/aerial.nvim',
  cmd = { 'AerialToggle', 'AerialOpen', 'AerialNavToggle', 'AerialNavOpen' },
  opts = {
    nav = {
      win_opts = {
        winblend = 0, -- opaque nav window (default is 10)
      },
    },
  },
  keys = {
    { '<leader>lo', '<cmd>AerialToggle<cr>', desc = 'Code Outline' },
  },
}
