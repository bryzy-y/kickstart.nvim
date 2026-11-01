-- oil.nvim: edit your filesystem like a buffer
-- https://github.com/stevearc/oil.nvim

---@module "lazy"
---@type LazySpec
return {
  {
    'stevearc/oil.nvim',
    -- Not lazy-loaded so it can replace netrw when opening a directory (e.g. `nvim .`)
    lazy = false,
    keys = {
      { '<leader>e', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    },
    opts = {},
  },
}
