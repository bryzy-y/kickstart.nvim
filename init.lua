--[[
  Personal Neovim config, based on kickstart-modular.nvim.

  Layout:
    lua/options.lua            Editor options
    lua/keymaps.lua            Basic keymaps, diagnostic config, basic autocommands
    lua/lazy-bootstrap.lua     Installs lazy.nvim
    lua/lazy-plugins.lua       lazy.nvim setup: lists the plugins to load
    lua/plugins/     One file per plugin, each required from lua/lazy-plugins.lua

  Run `:Lazy` to inspect, update or clean plugins.
--]]

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
-- Look into conjure or iron.nvim for repl integrations
require 'lazy-plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
