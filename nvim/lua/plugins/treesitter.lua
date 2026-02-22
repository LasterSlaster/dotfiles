-- =============================================================================
-- lua/plugins/treesitter.lua — Syntax parsing, highlighting, and context
-- =============================================================================

local not_vscode = function() return not vim.g.vscode end

return {

  -- --------------------------------------------------------------------------
  -- nvim-treesitter — accurate, fast syntax highlighting + structural editing
  -- :TSInstall <language>  to add parsers
  -- :TSUpdate              to update all installed parsers
  -- --------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    cond   = not_vscode,
    build  = ":TSUpdate",
    event  = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup({
        -- Install these parsers automatically on first run
        ensure_installed = {
          "bash",
          "css",
          "dart",
          "go",
          "html",
          "java",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        auto_install = true,   -- install missing parsers when opening a file
        highlight = {
          enable  = true,
          -- Disable for very large files to avoid slowness
          disable = function(_, buf)
            local max_filesize = 500 * 1024  -- 500 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        indent = { enable = true },
      })
    end,
  },

  -- --------------------------------------------------------------------------
  -- Treesitter context — always shows the opening line of the current block
  -- at the top of the window (e.g. the function signature while scrolling
  -- through its body).
  -- --------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter-context",
    cond         = not_vscode,
    event        = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable            = true,
      max_lines         = 3,   -- max number of context lines shown
      min_window_height = 20,  -- don't show context in very short windows
      trim_scope        = "outer",
    },
  },

  -- --------------------------------------------------------------------------
  -- nvim-treesitter-textobjects — syntax-aware text objects, move, swap
  -- Select: am/im (function), ac/ic (class). Move: ]m / [m (function), ]] / [[ (class).
  -- Swap: <leader>a / <leader>A (parameter). Repeat move: ; / ,
  -- --------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    cond    = not_vscode,
    branch  = "main",
    event   = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      -- Avoid conflicts with built-in ftplugin text-object maps (e.g. Python)
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"]  = "V",
            ["@class.outer"]     = "V",
          },
          include_surrounding_whitespace = false,
        },
        move = {
          set_jumps = true,
        },
      })

      -- Select: function (am/im), class (ac/ic)
      vim.keymap.set({ "x", "o" }, "am", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
      end, { desc = "Select a function" })
      vim.keymap.set({ "x", "o" }, "im", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
      end, { desc = "Select inner function" })
      vim.keymap.set({ "x", "o" }, "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
      end, { desc = "Select a class" })
      vim.keymap.set({ "x", "o" }, "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
      end, { desc = "Select inner class" })

      -- Move: next/previous function and class
      vim.keymap.set({ "n", "x", "o" }, "]m", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "[m", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous function start" })
      vim.keymap.set({ "n", "x", "o" }, "]]", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
      end, { desc = "Next class start" })
      vim.keymap.set({ "n", "x", "o" }, "[[", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
      end, { desc = "Previous class start" })

      -- Swap: next/previous parameter
      vim.keymap.set("n", "<leader>a", function()
        require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
      end, { desc = "Swap parameter with next" })
      vim.keymap.set("n", "<leader>A", function()
        require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
      end, { desc = "Swap parameter with previous" })

      -- Repeat last move with ; and ,
      local ts_repeat = require("nvim-treesitter-textobjects.repeatable_move")
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move_next, { desc = "Repeat move next" })
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous, { desc = "Repeat move previous" })
    end,
  },
}
