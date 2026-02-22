-- =============================================================================
-- lua/config/autocmds.lua — Autocommands
-- =============================================================================
-- Plugin-specific autocommands live in their plugin spec config functions.
-- =============================================================================

local augroup  = vim.api.nvim_create_augroup
local autocmd  = vim.api.nvim_create_autocmd

-- ----------------------------------------------------------------------------
-- Yank highlight
-- Replaces the vim-highlightedyank plugin — Neovim has this built-in.
-- ----------------------------------------------------------------------------
autocmd("TextYankPost", {
  group    = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Flash highlight on yank",
})

-- ----------------------------------------------------------------------------
-- Auto-read: reload buffer when the file changes on disk
-- ----------------------------------------------------------------------------
autocmd({ "FocusGained", "BufEnter" }, {
  group    = augroup("AutoRead", { clear = true }),
  pattern  = "*",
  command  = "checktime",
  desc     = "Reload file if changed outside Neovim",
})
