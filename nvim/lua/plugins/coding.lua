-- =============================================================================
-- lua/plugins/coding.lua — Editing and motion plugins
-- =============================================================================
-- These plugins are loaded in both standalone Neovim AND VSCode-neovim,
-- except HighStr which requires floating windows unavailable in VSCode.
-- =============================================================================

return {

  -- --------------------------------------------------------------------------
  -- Exchange two regions of text with each other
  -- cx<motion> to mark first region, cx<motion> again to swap
  -- cxx = current line, X = visual mode
  -- --------------------------------------------------------------------------
  { "tommcdo/vim-exchange", event = "VeryLazy" },

  -- nvim-surround → replaced by mini.surround  (ys / cs / ds — same keys)
  -- vim-move      → replaced by mini.move      (S-j/S-k visual, M-j/M-k normal)

  -- --------------------------------------------------------------------------
  -- Two-character seek motions (s + 2 chars)
  -- label = 1 shows EasyMotion-style jump labels
  -- --------------------------------------------------------------------------
  {
    "justinmk/vim-sneak",
    event = "VeryLazy",
    init  = function()
      vim.g["sneak#label"] = 1
    end,
  },

  -- --------------------------------------------------------------------------
  -- CamelCase / snake_case word motions
  -- Overrides w / b / e / ge to be case-boundary aware
  -- --------------------------------------------------------------------------
  {
    "bkad/CamelCaseMotion",
    event  = "VeryLazy",
    config = function()
      -- Map n/o/x modes only — select mode (s) is intentionally excluded
      -- so snippet placeholder jumping is not broken.
      for _, key in ipairs({ "w", "b", "e", "ge" }) do
        vim.keymap.set({ "n", "o", "x" }, key,
          "<Plug>CamelCaseMotion_" .. key,
          { silent = true, noremap = false })
      end
    end,
  },

  -- Comment.nvim → replaced by mini.comment  (gcc / gc<motion> — same keys)

  -- --------------------------------------------------------------------------
  -- Persistent text highlighting (up to 9 colour groups)
  -- Visual select, then <leader>h (highlight) / <leader>H (remove)
  -- Disabled in VSCode — requires proper floating windows
  -- --------------------------------------------------------------------------
  {
    "Pocco81/HighStr.nvim",
    cond   = function() return not vim.g.vscode end,
    event  = "VeryLazy",
    keys   = {
      { "<leader>h", ":<c-u>HSHighlight<CR>",   mode = "v", desc = "Highlight selection" },
      { "<leader>H", ":<c-u>HSRmHighlight<CR>", mode = "v", desc = "Remove highlight" },
    },
  },

  -- --------------------------------------------------------------------------
  -- Auto-detect indentation — reads shiftwidth/expandtab from the file itself
  -- instead of always defaulting to the global 2-space setting.
  -- --------------------------------------------------------------------------
  { "NMAC427/guess-indent.nvim", event = "BufReadPre", opts = {} },

  -- --------------------------------------------------------------------------
  -- Highlight TODO / FIXME / NOTE / HACK / WARN / PERF in comments
  -- :TodoQuickFix / :TodoFzf to browse them project-wide
  -- --------------------------------------------------------------------------
  {
    "folke/todo-comments.nvim",
    cond         = function() return not vim.g.vscode end,
    event        = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts         = { signs = false },
  },

  -- --------------------------------------------------------------------------
  -- Cheat.sh integration — look up snippets from the command line
  -- <leader>KB  search for explanation of last error
  -- <leader>KE  search for error message
  -- :HowIn javascript  search for JS version of current line
  -- --------------------------------------------------------------------------
  {
    "dbeniamine/cheat.sh-vim",
    event = "VeryLazy",
  },

  -- --------------------------------------------------------------------------
  -- Yank ring — keeps a history of yanks; ]p / [p cycle through them
  -- Replaces coc-yank.  Yank highlighting is handled by the TextYankPost
  -- autocmd in lua/config/autocmds.lua (Neovim built-in).
  -- --------------------------------------------------------------------------
  {
    "gbprod/yanky.nvim",
    cond  = function() return not vim.g.vscode end,
    event = "VeryLazy",
    opts = {
      ring = {
        history_length    = 100,
        storage           = "shada",
        sync_with_ring    = true,
      },
      highlight           = { on_put = true, on_yank = false, timer = 200 },
      -- on_yank = false: autocmds.lua already handles yank highlight
      preserve_cursor_position = { enabled = true },
    },
    keys = {
      { "p",   "<Plug>(YankyPutAfter)",     noremap = false, desc = "Paste after" },
      { "P",   "<Plug>(YankyPutBefore)",    noremap = false, desc = "Paste before" },
      { "gp",  "<Plug>(YankyGPutAfter)",    noremap = false, desc = "Paste after (keep cursor)" },
      { "gP",  "<Plug>(YankyGPutBefore)",   noremap = false, desc = "Paste before (keep cursor)" },
      { "]p",  "<Plug>(YankyCycleForward)", noremap = false, desc = "Cycle yank ring forward" },
      { "[p",  "<Plug>(YankyCycleBackward)", noremap = false, desc = "Cycle yank ring backward" },
    },
  },

  -- --------------------------------------------------------------------------
  -- Markdown preview — renders the current buffer in a browser tab
  -- Replaces coc-markdown-preview-enhanced + coc-webview.
  -- :MarkdownPreview        open preview
  -- :MarkdownPreviewStop    close preview
  -- :MarkdownPreviewToggle  toggle
  -- --------------------------------------------------------------------------
  {
    "iamcco/markdown-preview.nvim",
    cond  = function() return not vim.g.vscode end,
    cmd   = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft    = { "markdown" },
    build = "cd app && npx --yes yarn install",
  },
}
