-- =============================================================================
-- init.lua — Neovim entry point
-- =============================================================================
-- Leader key MUST be set before lazy.nvim loads plugins so all plugin
-- keymaps inherit the correct leader.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable unused providers to suppress :checkhealth warnings
vim.g.loaded_perl_provider = 0

-- Bootstrap lazy.nvim and load all plugin specs from lua/plugins/
require("config.lazy")

-- Core Neovim settings (options, keymaps, autocmds are loaded after plugins
-- so that plugin-provided functions/commands are available if needed)
require("config.options")
require("config.keymaps")
require("config.autocmds")
