-- =============================================================================
-- lua/plugins/ui.lua — Colorschemes, statusline, start screen, which-key
-- =============================================================================
-- All plugins here are disabled in VSCode (VSCode manages its own UI).
-- =============================================================================

local not_vscode = function() return not vim.g.vscode end

return {

  -- --------------------------------------------------------------------------
  -- Colorschemes
  -- --------------------------------------------------------------------------
  {
    "rose-pine/neovim",
    name     = "rose-pine",
    cond     = not_vscode,
    priority = 1000,  -- load before other plugins so the theme is ready
    config   = function()
      require("rose-pine").setup({ variant = "moon" })
      vim.cmd("colorscheme rose-pine")
      -- Transparent terminal background
      -- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    end,
  },
  { "morhetz/gruvbox",            cond = not_vscode, lazy = true },
  { "folke/tokyonight.nvim",      cond = not_vscode, lazy = true },
  { "joshdick/onedark.vim",       cond = not_vscode, lazy = true },

  -- --------------------------------------------------------------------------
  -- nvim-numbertoggle — switches to absolute line numbers automatically when:
  --   • the buffer loses focus
  --   • entering insert mode
  --   • the cursor is on line 0 (so the current line always shows its real number)
  -- Switches back to relative numbers in normal mode with focus.
  -- --------------------------------------------------------------------------
  {
    "sitiom/nvim-numbertoggle",
    cond  = not_vscode,
    event = { "BufReadPost", "BufNewFile", "InsertEnter", "FocusLost" },
  },

  -- --------------------------------------------------------------------------
  -- Which-key: show pending keybinding hints after <leader>
  -- Lua-native v3 replacement for liuchengxu/vim-which-key
  -- --------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    cond  = not_vscode,
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        delay = 500,  -- ms before the popup appears
      })

      -- Define label groups so the popup is more descriptive
      wk.add({
        { "<leader>c",  group = "code" },     -- LSP: diagnostics, outline, symbols
        { "<leader>g",  group = "git" },
        { "<leader>gh", group = "git hunk" },
        { "<leader>K",  group = "cheat.sh" },
      })
    end,
  },
}
