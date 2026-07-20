-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Some terminals display a gap between the terminal background and the Neovim background
-- This autocommand fixes that by setting the terminal background color to match Neovim's
-- through escape sequences (OSC 11 & 111)
vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then return end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})

vim.api.nvim_create_autocmd({ 'UILeave' }, {
  callback = function() io.write '\x1b]111;\x1b\\' end,
})

-- Show the tabline only if there are at least two listed buffers
vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
  group = vim.api.nvim_create_augroup('MiniTablineAutohide', { clear = true }),
  callback = function()
    -- Give UI a chance to update the buffer list after a buffer is deleted
    vim.schedule(function()
      local listed_bufs = vim.tbl_filter(function(buf) return vim.bo[buf].buflisted end, vim.api.nvim_list_bufs())

      if #listed_bufs > 1 then
        vim.opt.showtabline = 2
      else
        vim.opt.showtabline = 1
      end
    end)
  end,
})

-- Disable automatic comment insertion on new lines with 'o' or 'O' in normal mode
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('DisableCommentAutoInsert', { clear = true }),
  pattern = '*',
  callback = function() vim.opt_local.formatoptions:remove { 'o' } end,
})
