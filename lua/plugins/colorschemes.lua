-- [[ Colorschemes ]]
-- The active colorscheme loads at startup (`lazy = false`, high `priority`).
-- The others are `lazy = true`: lazy.nvim loads them automatically when you
-- run `:colorscheme <name>` (or pick one with `:Telescope colorscheme`).
--
-- To switch the default, move `lazy = false` + `priority` + the `vim.cmd.colorscheme`
-- call to another entry.

return {
  'sainnhe/everforest',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.everforest_background = 'soft' -- "hard" | "medium" (default) | "soft"
    vim.g.everforest_transparent_background = 1
    vim.g.everforest_ui_contrast = 'high' -- brighter line numbers, indent guides, etc.
    vim.g.everforest_float_style = 'bright' -- "bright" | "dim" | "blend"
    vim.g.everforest_diagnostic_virtual_text = 'colored' -- "grey" (default) | "colored" | "highlighted"
    vim.g.everforest_enable_italic = false -- needs a font with cursive italics
    vim.cmd.colorscheme 'everforest'
  end,
}
