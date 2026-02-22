-- =============================================================================
-- lua/plugins/tools.lua — Productivity / tool plugins
-- =============================================================================
-- fzf, terminal (toggleterm), undotree, window management, CSS colours.
-- All disabled in VSCode except cheat.sh (which lives in coding.lua).
-- =============================================================================

local not_vscode = function() return not vim.g.vscode end

return {

  -- --------------------------------------------------------------------------
  -- fzf — fuzzy file / text search
  -- Bindings:
  --   <C-p>       fuzzy file search (Files)
  --   <leader>s   ripgrep project search (Rg)
  --   <leader>b   open buffer list
  --   <leader>/   search lines in current buffer
  --   <leader>H   file history
  --   <leader>gc  git branch checkout (fzf-checkout)
  --   <leader>gs  git status (fugitive :G)
  --   <leader>gb  git branch list
  -- --------------------------------------------------------------------------
  {
    "junegunn/fzf",
    cond  = not_vscode,
    build = "./install --bin",  -- installs the fzf binary without shell integrations
  },
  {
    "junegunn/fzf.vim",
    cond         = not_vscode,
    event        = "VeryLazy",
    dependencies = { "junegunn/fzf" },
    config       = function()
      -- Floating window layout
      vim.g.fzf_layout = { window = { width = 0.9, height = 0.9 } }

      vim.env.FZF_DEFAULT_OPTS =
        "--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 " ..
        "--preview 'bat --color=always --style=header,grid --line-range :300 {}'"

      -- Prefer fd → rg → ag for listing files
      if vim.fn.executable("fd") == 1 then
        vim.env.FZF_DEFAULT_COMMAND =
          "fd --type f --hidden --follow --exclude .git --exclude .idea"
      elseif vim.fn.executable("rg") == 1 then
        vim.env.FZF_DEFAULT_COMMAND =
          "rg --files --hidden --follow --glob '!.git' --glob '!.idea'"
      else
        vim.env.FZF_DEFAULT_COMMAND =
          'ag --hidden --ignore=.git --ignore=.idea -g ""'
      end

      -- Custom commands that add ripgrep / git grep support to fzf.vim
      vim.cmd([[
        command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>,
          \   fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}),
          \   <bang>0)

        command! -bang -nargs=* GGrep
          \ call fzf#vim#grep(
          \   'git grep --line-number -- '.shellescape(<q-args>), 0,
          \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}),
          \   <bang>0)

        command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --hidden --line-number --no-heading --color=always --smart-case -- '
          \   .shellescape(<q-args>), 1,
          \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
          \   <bang>0)
      ]])

      local map = vim.keymap.set

      -- File / project search
      map("n", "<C-p>",      "<esc>:Files<CR>",   { silent = true, desc = "Find files (fzf)" })
      map("n", "<leader>s",  ":Rg<CR>",            { desc = "Project search (Rg)" })
      map("n", "<leader>/",  ":BLines<CR>",         { desc = "Search buffer lines" })
      map("n", "<leader>b",  ":Buffers<CR>",        { desc = "Buffer list" })
      map("n", "<leader>H",  ":History<CR>",        { desc = "File history" })

      -- Git helpers
      map("n", "<leader>gs", ":G<CR>",              { desc = "Git status (fugitive)" })

      -- Path completion in insert mode
      map("i", "<c-x><c-f>",
        "fzf#vim#complete#path(fzf#wrap({'dir': expand('%:p:h')}))",
        { expr = true, desc = "Path completion (fzf)" })

      -- In a Neovim terminal inside fzf, Esc should exit the terminal, not
      -- send escape to fzf (which would close the popup unintentionally).
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern  = "*",
        command  = "tmap <buffer> <Esc> <C-\\><C-n>",
        desc     = "Esc exits terminal mode",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern  = "fzf",
        command  = "tunmap <buffer> <Esc>",
        desc     = "Restore Esc inside fzf",
      })
    end,
  },

  -- fzf-based git branch checkout
  {
    "stsewd/fzf-checkout.vim",
    cond         = not_vscode,
    event        = "VeryLazy",
    dependencies = { "junegunn/fzf.vim" },
    config       = function()
      local map = vim.keymap.set
      map("n", "<leader>gc", ":GCheckout<CR>", { desc = "Git checkout (fzf)" })
      map("n", "<leader>gb", ":GBranches<CR>", { desc = "Git branches (fzf)" })
    end,
  },

  -- --------------------------------------------------------------------------
  -- conform.nvim — async formatter that works with any external tool
  -- Runs on save; falls back to coc's LSP formatter if no formatter is found.
  -- Add per-filetype formatters under formatters_by_ft as needed.
  -- :ConformInfo  shows what formatters are active for the current buffer.
  -- --------------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    cond  = not_vscode,
    event = "BufWritePre",
    cmd   = "ConformInfo",
    keys  = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Format buffer (conform)",
      },
    },
    opts = {
      -- Format silently on save with a 500 ms timeout.
      -- Set to nil (or remove) to disable format-on-save entirely.
      format_on_save = function(bufnr)
        -- Skip format-on-save for files without a configured formatter so that
        -- coc doesn't get a spurious trigger either.
        local ft = vim.bo[bufnr].filetype
        local have_formatter = #require("conform").list_formatters(bufnr) > 0
        if not have_formatter then return nil end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,

      formatters_by_ft = {
        lua        = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        json       = { "prettierd", "prettier", stop_after_first = true },
        css        = { "prettierd", "prettier", stop_after_first = true },
        html       = { "prettierd", "prettier", stop_after_first = true },
        python     = { "black" },
        go         = { "goimports", "golines" },
        sh         = { "shfmt" },
        -- scala / dart / java — handled by coc-metals / coc-flutter / coc-java
      },
    },
  },

  -- --------------------------------------------------------------------------
  -- Toggleterm — Lua-native replacement for vim-floaterm
  -- <leader>,     toggle the last / default terminal
  -- <leader>gg    lazygit in a floating terminal
  -- Inside the terminal:
  --   ,q          hide terminal
  --   ,<space>    toggle terminal
  --   <A-]>       send literal Esc to the running program
  -- --------------------------------------------------------------------------
  {
    "akinsho/toggleterm.nvim",
    cond    = not_vscode,
    version = "*",
    event   = "VeryLazy",
    config  = function()
      require("toggleterm").setup({
        size      = function(term)
          if term.direction == "horizontal" then return 15
          elseif term.direction == "vertical" then return vim.o.columns * 0.4
          end
        end,
        open_mapping    = nil,          -- we define our own mappings below
        direction       = "float",
        float_opts      = { border = "curved" },
        shade_terminals = false,
      })

      local map = vim.keymap.set

      -- Toggle default floating terminal
      map("n", "<leader>,", "<cmd>ToggleTerm<CR>",
        { silent = true, desc = "Toggle terminal" })

      -- Lazygit in a floating terminal
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit  = Terminal:new({
        cmd       = "lazygit",
        direction = "float",
        hidden    = true,
        float_opts = { border = "curved" },
        on_open   = function(t)
          -- Esc in normal mode inside lazygit terminal closes it
          vim.keymap.set("n", "<Esc>", "<cmd>close<CR>",
            { buffer = t.bufnr, silent = true })
        end,
      })

      map("n", "<leader>gg", function() lazygit:toggle() end,
        { silent = true, desc = "Toggle lazygit" })

      -- Terminal mode bindings (mirrors former floaterm ,* bindings)
      map("t", "<A-]>",    "<Esc>",               { desc = "Send Esc to program" })
      map("t", ",q",       "<cmd>ToggleTerm<CR>", { desc = "Hide terminal" })
      map("t", ",<space>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
    end,
  },

  -- --------------------------------------------------------------------------
  -- Undotree — visual undo history browser
  -- <leader>u to open
  -- --------------------------------------------------------------------------
  {
    "mbbill/undotree",
    cond  = not_vscode,
    event = "VeryLazy",
    keys  = {
      { "<leader>u", ":UndotreeShow<CR>", desc = "Open undotree" },
    },
  },

  -- --------------------------------------------------------------------------
  -- nvim-window — interactive window picker
  -- <leader><leader> shows labels; press the label letter to jump
  -- --------------------------------------------------------------------------
  {
    "https://gitlab.com/yorickpeterse/nvim-window.git",
    cond  = not_vscode,
    event = "VeryLazy",
    keys  = {
      {
        "<leader><leader>",
        function() require("nvim-window").pick() end,
        desc = "Pick window",
      },
    },
    config = function()
      require("nvim-window").setup({})
    end,
  },

  -- --------------------------------------------------------------------------
  -- WinShift — move and swap windows interactively
  -- <C-W><C-M> / <C-W>m  enter Win-Move mode
  -- <C-W>x               swap two windows
  -- --------------------------------------------------------------------------
  {
    "sindrets/winshift.nvim",
    cond  = not_vscode,
    event = "VeryLazy",
    keys  = {
      { "<C-W><C-M>", "<cmd>WinShift<CR>",      desc = "Win-Move mode" },
      { "<C-W>m",     "<cmd>WinShift<CR>",      desc = "Win-Move mode" },
      { "<C-W>x",     "<cmd>WinShift swap<CR>", desc = "Swap windows" },
      { "<C-M-H>",    "<cmd>WinShift left<CR>",  desc = "Move window left" },
      { "<C-M-J>",    "<cmd>WinShift down<CR>",  desc = "Move window down" },
      { "<C-M-K>",    "<cmd>WinShift up<CR>",    desc = "Move window up" },
      { "<C-M-L>",    "<cmd>WinShift right<CR>", desc = "Move window right" },
    },
    config = function()
      require("winshift").setup()
    end,
  },

  -- ap/vim-css-color → replaced by mini.hipatterns hex_color highlighter

  -- --------------------------------------------------------------------------
  -- vim-suda — read / write files with sudo without restarting Neovim
  -- :SudaRead  [path]   open a root-owned file into current buffer
  -- :SudaWrite [path]   save current buffer with sudo
  -- <leader>W           quick :SudaWrite shortcut
  -- --------------------------------------------------------------------------
  {
    "lambdalisue/vim-suda",
    cond = not_vscode,
    cmd  = { "SudaRead", "SudaWrite" },
    keys = {
      { "<leader>W", "<cmd>SudaWrite<CR>", desc = "Write with sudo" },
    },
  },
}
