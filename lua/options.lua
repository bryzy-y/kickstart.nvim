-- [[ Options ]]
--  See `:help vim.o`
--  For more options, you can see `:help option-list`

-- Delete swap files
vim.opt.swapfile = false

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'` and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- nicer borders
vim.o.winborder = 'solid'

-- GitHub-style diffs (split view)
--  See `:help 'diffopt'`
vim.opt.diffopt = {
  'internal', -- built-in diff engine
  'filler', -- blank filler lines keep both sides aligned
  'closeoff', -- leave diff mode when only one diff window remains
  'vertical', -- side by side, like GitHub's split view
  'indent-heuristic', -- git's default hunk boundaries (algorithm stays git's default, myers)
  'linematch:60', -- pair up changed lines within a hunk, like GitHub's split rows
  'inline:word', -- highlight changed words within a line
  'context:3', -- fold unchanged code beyond 3 lines of context, like GitHub's collapsed sections
  --'followwrap', -- keep 'wrap' in diff windows; GitHub wraps long lines
}
vim.opt.fillchars:append { diff = ' ' } -- plain empty filler lines, like GitHub

-- vim: ts=2 sts=2 sw=2 et
