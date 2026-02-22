-- =============================================================================
-- lua/config/lazy.lua — lazy.nvim bootstrap
-- =============================================================================
-- Auto-installs lazy.nvim if not present, then calls lazy.setup() which
-- scans lua/plugins/*.lua for plugin specs.
-- =============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Auto-import every file in lua/plugins/
  spec = { { import = "plugins" } },

  defaults = {
    lazy = false,    -- plugins load at startup unless they set lazy = true
    version = false, -- always use the latest commit, not a tagged version
  },

  install = {
    -- Fallback colorschemes used while plugins are being installed
    colorscheme = { "rose-pine", "habamax" },
  },

  checker = {
    enabled = false, -- disable automatic update checks on startup
  },

  performance = {
    rtp = {
      -- Disable built-in plugins we never use to shave startup time
      disabled_plugins = {
        "gzip",
        "netrwPlugin",  -- we configure netrw but disable its auto-open behaviour
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
