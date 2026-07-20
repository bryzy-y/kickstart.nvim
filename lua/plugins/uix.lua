-- ============================================================
-- UI / CORE UX PLUGINS
-- ============================================================
--
-- Automatically detect the indentation settings of a file
require('guess-indent').setup {}
-- Smooth scrolling for Neovim
require('neoscroll').setup()

-- Add autopairs for brackets, quotes, etc.
require('nvim-autopairs').setup {}
-- Add autopairs for tags in HTML, XML, etc.
require('nvim-ts-autotag').setup {}

-- See `:help gitsigns` to understand what each configuration key does.
-- Adds git related signs to the gutter, as well as utilities for managing changes
require('gitsigns').setup {
  signs = {
    add = { text = '+' }, ---@diagnostic disable-line: missing-fields
    change = { text = '~' }, ---@diagnostic disable-line: missing-fields
    delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
    topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
    changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
  },
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions
    -- visual mode
    map(
      'v',
      '<leader>hs',
      function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
      { desc = 'git [s]tage hunk' }
    )
    map(
      'v',
      '<leader>hr',
      function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
      { desc = 'git [r]eset hunk' }
    )
    -- normal mode
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline' })
    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [b]lame line' })
    -- map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    -- map('n', '<leader>hD', function() gitsigns.diffthis '@' end, { desc = 'git [D]iff against last commit' })
    -- map('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, { desc = 'git hunk [Q]uickfix list (all files in repo)' })
    -- map('n', '<leader>hq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)' })

    -- Toggles
    map('n', '<leader>ub', gitsigns.toggle_current_line_blame, { desc = 'Toggle git [b]lame line' })

    -- Text object
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
  end,
}

-- Highlight todo, notes, etc in comments
require('todo-comments').setup { signs = false }

-- Useful plugin to show you pending keybinds.
require('which-key').setup {
  preset = 'helix',
  icons = { mappings = vim.g.have_nerd_font },
  -- Document existing key chains
  spec = {
    {
      mode = { 'n', 'x' },
      { '<leader>l', group = 'lsp', icon = { icon = '󰞋', color = 'red' } },
      { '<leader>f', group = 'file/find' },
      { '<leader>g', group = 'git' },
      { '<leader>gd', group = 'diffview' },
      { '<leader>gh', group = 'hunks' },
      { '<leader>q', group = 'quit/session' },
      { '<leader>s', group = 'search' },
      { '<leader>t', group = 'test' },
      { '<leader>u', group = 'ui' },
      { '<leader>p', group = 'pack', icon = { icon = '📦' } },
      { '<leader>m', group = 'misc', icon = { icon = '' } },
      { '[', group = 'prev' },
      { ']', group = 'next' },
      { 'g', group = 'goto' },
      { 'gs', group = 'surround' },
      { 'z', group = 'fold' },
      {
        '<leader>b',
        group = 'buffer',
        expand = function() return require('which-key.extras').expand.buf() end,
      },
      {
        '<leader>w',
        group = 'windows',
        proxy = '<c-w>',
        expand = function() return require('which-key.extras').expand.win() end,
      },
      -- better descriptions
      { 'gx', desc = 'Open with system app' },
    },
  },
}

if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
  MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup {
  -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require 'mini.statusline'
-- Set `use_icons` to true if you have a Nerd Font
statusline.setup {
  use_icons = vim.g.have_nerd_font,
}

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end

-- Tabline
require('mini.tabline').setup()

-- Moves
require('mini.move').setup()

-- [[ Colorscheme ]]
-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command under that to load whatever the name of that colorscheme is.

require('rose-pine').setup {
  styles = {
    italic = false,
  },
}

---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
}

-- Load the colorscheme here.
-- Like many other themes, this one has different styles, and you could load
-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
vim.cmd.colorscheme 'tokyonight-night'
