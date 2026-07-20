-- ============================================================
-- PLUGIN MANAGER
-- vim.pack and all installed plugins are managed in this file.
-- ============================================================
--
-- [[ Intro to `vim.pack` ]]
-- `vim.pack` is a new plugin manager built into Neovim,
--  which provides a Lua interface for installing and managing plugins.
--
--  See `:help vim.pack`, `:help vim.pack-examples` or the
--  excellent blog post from the creator of vim.pack and mini.nvim:
--  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
--
--  To inspect plugin state and pending updates, run
--    :lua vim.pack.update(nil, { offline = true })
--
--  To update plugins, run
--    :lua vim.pack.update()
--
--
--  In this section we set up some autocommands to run build
--  steps for certain plugins after they are installed or updated.

local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then output = 'No output from build command.' end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

-- This autocommand runs after a plugin is installed or updated and
-- runs the appropriate build command for that plugin if necessary.
--
-- See `:help vim.pack-events`
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
      return
    end

    if name == 'LuaSnip' then
      if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
      end
      return
    end

    if name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
      return
    end

    if name == 'markdown-preview.nvim' and kind ~= 'delete' then
      if not ev.data.active then vim.cmd.packadd 'markdown-preview.nvim' end
      vim.fn['mkdp#util#install']()
      return
    end
  end,
})

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  -- UI & UX
  gh 'NMAC427/guess-indent.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'folke/which-key.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'windwp/nvim-autopairs',
  gh 'windwp/nvim-ts-autotag',
  gh 'karb94/neoscroll.nvim',

  -- mini modules
  gh 'nvim-mini/mini.nvim',

  -- Themes
  gh 'folke/tokyonight.nvim',
  {
    src = gh 'rose-pine/neovim',
    name = 'rose-pine',
  },

  -- LSP & Mason
  gh 'j-hui/fidget.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',

  -- Formatting & linting
  gh 'stevearc/conform.nvim',
  -- gh 'mfussenegger/nvim-lint',

  -- Treesitter
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },

  -- Autocomplete Engine & Snippets
  { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
  gh 'rafamadriz/friendly-snippets',
  { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },

  -- snacks modules
  gh 'folke/snacks.nvim',

  --Pleasant lua dev experience
  gh 'folke/lazydev.nvim',

  -- oil file explorer
  gh 'stevearc/oil.nvim',
  gh 'refractalize/oil-git-status.nvim',

  -- noice
  gh 'MunifTanjim/nui.nvim',
  gh 'folke/noice.nvim',

  -- dbt
  gh 'nvim-lua/plenary.nvim',
  gh 'PedramNavid/dbtpal',

  -- copilot
  gh 'github/copilot.vim',

  -- git diffview
  gh 'sindrets/diffview.nvim',

  -- markdown preview
  gh 'iamcco/markdown-preview.nvim',
}
