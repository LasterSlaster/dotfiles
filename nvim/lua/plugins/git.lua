-- =============================================================================
-- lua/plugins/git.lua — Git integration plugins
-- =============================================================================

local not_vscode = function() return not vim.g.vscode end

return {

  -- --------------------------------------------------------------------------
  -- Fugitive — the definitive Git plugin for Vim
  -- :G / :Git for the status window
  -- :GV for the commit browser (provided by gv.vim below)
  -- --------------------------------------------------------------------------
  {
    "tpope/vim-fugitive",
    cond  = not_vscode,
    event = "VeryLazy",
    -- Keymaps are set in tools.lua alongside fzf-checkout since they share
    -- the <leader>g prefix
  },

  -- --------------------------------------------------------------------------
  -- GV — pretty git commit browser built on top of fugitive
  -- :GV        browse commits
  -- :GV!       commits for current file
  -- :GV?       show revisions of current file (populates quickfix)
  -- --------------------------------------------------------------------------
  {
    "junegunn/gv.vim",
    cond         = not_vscode,
    event        = "VeryLazy",
    dependencies = { "tpope/vim-fugitive" },
  },

  -- --------------------------------------------------------------------------
  -- git-worktree — create, switch, and delete git worktrees
  -- Uses a custom fzf picker since this config does not use Telescope.
  --
  -- Keymaps:
  --   <leader>gws   switch worktree (fzf picker)
  --   <leader>gwc   create worktree (prompts for branch + path)
  --   <leader>gwd   delete worktree (fzf picker)
  -- --------------------------------------------------------------------------
  {
    "ThePrimeagen/git-worktree.nvim",
    cond         = not_vscode,
    event        = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config       = function()
      require("git-worktree").setup()

      -- Helper: show a fzf picker over all current worktrees and call action(path)
      local function pick_worktree(prompt, action)
        local lines = vim.fn.systemlist("git worktree list")
        if vim.v.shell_error ~= 0 or #lines == 0 then
          vim.notify("git worktree list failed (not a git repo?)", vim.log.levels.WARN)
          return
        end
        vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
          source  = lines,
          options = "--no-preview --prompt='" .. prompt .. "> '",
          sink    = function(line)
            -- first field is the absolute path
            local path = vim.split(line, "%s+")[1]
            action(path)
          end,
        }))
      end

      local wt  = require("git-worktree")
      local map = vim.keymap.set

      -- Switch worktree
      map("n", "<leader>gws", function()
        pick_worktree("Switch worktree", function(path)
          wt.switch_worktree(path)
        end)
      end, { desc = "Switch worktree" })

      -- Delete worktree
      map("n", "<leader>gwd", function()
        pick_worktree("Delete worktree", function(path)
          vim.ui.input({ prompt = "Delete worktree '" .. path .. "'? [y/N] " }, function(input)
            if input and input:lower() == "y" then
              wt.delete_worktree(path)
            end
          end)
        end)
      end, { desc = "Delete worktree" })

      -- Create worktree
      map("n", "<leader>gwc", function()
        vim.ui.input({ prompt = "Branch name: " }, function(branch)
          if not branch or branch == "" then return end
          vim.ui.input({
            prompt  = "Worktree path (default: ../" .. branch .. "): ",
            default = "../" .. branch,
          }, function(path)
            if not path or path == "" then return end
            wt.create_worktree(path, branch)
          end)
        end)
      end, { desc = "Create worktree" })
    end,
  },

  -- --------------------------------------------------------------------------
  -- Gitsigns — Lua-native replacement for vim-gitgutter
  -- Faster, more accurate, and supports blame, line highlights, and hunks.
  -- --------------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    cond  = not_vscode,
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,  -- virtual-text blame on the current line
        current_line_blame_opts = {
          delay        = 500,       -- ms before the annotation appears
          virt_text_pos = "eol",    -- end of line (same position as git-blame.nvim)
        },
        signs = {
          add          = { text = "│" },
          change       = { text = "│" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
          untracked    = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs  = package.loaded.gitsigns
          local map = function(mode, l, r, opts)
            opts        = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigate between hunks (mirrors old [c / ]c gitgutter bindings)
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Next hunk" })

          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Previous hunk" })

          -- Hunk actions (mirrors old gitgutter <leader>gh* bindings)
          map("n", "<leader>ghs", gs.stage_hunk,           { desc = "Stage hunk" })
          map("n", "<leader>ghu", gs.reset_hunk,            { desc = "Undo/reset hunk" })
          map("n", "<leader>ghp", gs.preview_hunk,          { desc = "Preview hunk" })
          map("n", "<leader>ghb", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame line" })

          -- Stage/reset visual selection
          map("v", "<leader>ghs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage selected hunk" })
          map("v", "<leader>ghu", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Undo selected hunk" })
        end,
      })
    end,
  },
}
