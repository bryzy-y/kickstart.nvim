-- Add indentation guides even on blank lines

return {
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  ---@module 'ibl'
  ---@type ibl.config
  opts = {
    indent = {
      char = '▏',
    },
    scope = {
      show_start = false,
      show_end = false,
    },
  },
}
