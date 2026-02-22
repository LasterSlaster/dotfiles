-- =============================================================================
-- lua/plugins/explorer.lua — File explorer (neo-tree)
-- =============================================================================
-- Replaces coc-explorer.
--
-- Bindings:
--   <leader>e    toggle the explorer panel (left side)
--
-- Inside the explorer:
--   a            add file / directory
--   d            delete
--   r            rename
--   y            copy path
--   c / p        copy / paste
--   <CR>         open
--   s / S        open in horizontal / vertical split
--   <BS>         navigate up one directory
--   H            toggle hidden files
--   /            fuzzy search in the tree
--   R            refresh
--   q            close
-- =============================================================================

local not_vscode = function() return not vim.g.vscode end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch       = "v3.x",
    cond         = not_vscode,
    cmd          = "Neotree",
    keys         = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- nvim-web-devicons is provided by mini.icons via its compat shim
      -- (see lua/plugins/mini.lua) — no explicit dependency needed here.
    },

    -- Open neo-tree automatically when Neovim is invoked with a directory
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("NeoTreeDirOpen", { clear = true }),
        once  = true,
        callback = function()
          local bufname = vim.fn.expand("%")
          if vim.fn.isdirectory(bufname) == 1 then
            -- Delete the directory buffer so the main window is empty
            local buf = vim.api.nvim_get_current_buf()
            vim.cmd("enew")
            vim.api.nvim_buf_delete(buf, { force = true })
            vim.cmd("Neotree reveal")
          end
        end,
      })
    end,

    opts = {
      close_if_last_window = true,

      window = {
        position = "left",
        width    = 30,
        mappings = {
          -- Keep familiar coc-explorer-ish keys
          ["<CR>"]   = "open",
          ["s"]      = "open_split",
          ["S"]      = "open_vsplit",
          ["R"]      = "refresh",
          ["H"]      = "toggle_hidden",
          ["q"]      = "close_window",
          ["<BS>"]   = "navigate_up",
          ["."]      = "set_root",
          ["/"]      = "fuzzy_finder",
          ["a"]      = { "add", config = { show_path = "relative" } },
          ["d"]      = "delete",
          ["r"]      = "rename",
          ["c"]      = "copy",
          ["m"]      = "move",
          ["y"]      = "copy_to_clipboard",
          ["p"]      = "paste_from_clipboard",
        },
      },

      filesystem = {
        filtered_items = {
          visible         = false,  -- hide dotfiles by default; <H> toggles
          hide_dotfiles   = true,
          hide_gitignored = true,
        },
        follow_current_file  = { enabled = true },  -- reveal open file in tree
        hijack_netrw_behavior = "open_current",      -- replace netrw dir handling
        use_libuv_file_watcher = true,               -- auto-refresh on changes
      },

      git_status = {
        window = {
          position = "float",
        },
      },

      default_component_configs = {
        git_status = {
          symbols = {
            added     = "",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
      },
    },
  },
}
