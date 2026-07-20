local function delete_unused()
  local p = vim
    .iter(vim.pack.get())
    :filter(function(x) return not x.active end)
    :map(function(x) return x.spec.name end)
    :totable()

  -- Check if there are any unused packages
  if #p == 0 then
    vim.notify('No unused packages found', vim.log.levels.INFO)
    return
  end

  -- Delete the unused packages
  vim.pack.del(p)

  local msg = string.format('Deleted %d packages', #p)
  vim.notify(msg, vim.log.levels.INFO)
end

-- Keymaps
vim.keymap.set('n', '<leader>pU', function() vim.pack.update() end, { desc = 'Update packages' })
vim.keymap.set('n', '<leader>pD', function() delete_unused() end, { desc = 'Delete unused packages' })
vim.keymap.set(
  'n',
  '<leader>pS',
  function() vim.pack.update(nil, { target = 'lockfile' }) end,
  { desc = 'Sync packages from lockfile' }
)
vim.keymap.set(
  'n',
  '<leader>pl',
  function() vim.pack.update(nil, { offline = true }) end,
  { desc = 'List packages' }
)
