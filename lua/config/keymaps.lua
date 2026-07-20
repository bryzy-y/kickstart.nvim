-- ============================================================
-- KEYMAPS
-- basic keymaps
-- ============================================================
--
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
--  See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Make j/k move by visual lines instead of actual lines, which is more intuitive when lines wrap.
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

vim.keymap.set('n', 'Q', 'q', { desc = 'Record macro' })
vim.keymap.set('n', 'q', '<Nop>', { desc = 'Disable q to avoid accidental macro recording' })

vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Oil' })
vim.keymap.set('x', '<leader>/', 'gc', { remap = true, desc = 'Comment selection' })
vim.keymap.set('n', '<leader>qq', '<Cmd>qa<CR>', { desc = 'Quit all' })
vim.keymap.set('n', '<leader>\\', '<Cmd>vsplit<CR>', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>-', '<Cmd>split<CR>', { desc = 'Split horizontally' })
vim.keymap.set('n', '<leader>wq', '<Cmd>close<CR>', { desc = 'Close window' })
vim.keymap.set('n', '<leader>wo', '<Cmd>only<CR>', { desc = 'Close other windows' })
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file', silent = true })

-- Move along the tabline with H / L
vim.keymap.set('n', 'L', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', 'H', '<Cmd>bprevious<CR>', { desc = 'Previous buffer' })

-- Smart accept
vim.keymap.set('i', '<C-l>', 'copilot#Accept("")', { expr = true, silent = true, replace_keycodes = false })

-- Misc
vim.keymap.set({ 'n', 'v' }, '<leader>ml', function()
  local row = nil
  local mode = vim.fn.mode()
  if mode ~= 'n' then
    local s = vim.fn.line 'v'
    local e = vim.fn.line '.'
    if s > e then
      s, e = e, s
    end
    row = s .. '-' .. e
  else
    row = unpack(vim.api.nvim_win_get_cursor(0))
  end
  local file = vim.fn.expand '%'
  vim.fn.setreg('+', file .. '#L' .. row)
end, { desc = 'Yank line anchor' })
