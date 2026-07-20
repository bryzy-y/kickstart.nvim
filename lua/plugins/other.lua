-- ==========================================================================================
-- Other plugins that i'm lazy to break into separate files, but still want to keep organized
-- ==========================================================================================

do
  require('diffview').setup {
    hooks = {
      diff_buf_read = function(_) vim.opt_local.relativenumber = false end,
    },
  }

  vim.keymap.set('n', '<leader>gdd', function() vim.cmd 'DiffviewOpen' end, { desc = 'Open' })
  vim.keymap.set('n', '<leader>gdq', function() vim.cmd 'DiffviewClose' end, { desc = 'Close' })
  vim.keymap.set('n', '<leader>gdh', function() vim.cmd 'DiffviewFileHistory' end, { desc = 'History' })
end

do
  require('lazydev').setup {
    ft = 'lua',
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  }
end

do
  require('noice').setup {
    cmdline = {
      enabled = true,
    },
    messages = {
      enabled = false,
    },

    lsp = {
      progress = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },

    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  }

  vim.keymap.set({ 'i', 'n', 's' }, '<c-f>', function()
    if not require('noice.lsp').scroll(4) then return '<c-f>' end
  end, { silent = true, expr = true, desc = 'Scroll Forward' })

  vim.keymap.set({ 'i', 'n', 's' }, '<c-b>', function()
    if not require('noice.lsp').scroll(-4) then return '<c-b>' end
  end, { silent = true, expr = true, desc = 'Scroll Backward' })
end

do
  require('dbtpal').setup {}
end
