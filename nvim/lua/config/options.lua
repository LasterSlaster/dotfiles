-- =============================================================================
-- lua/config/options.lua — Vim/Neovim options
-- =============================================================================
-- Most options are set unconditionally. VSCode-neovim ignores options it
-- cannot render (e.g. statusline, cursorline) but behavioural options like
-- ignorecase, scrolloff, clipboard etc. still apply there.
-- =============================================================================

local opt = vim.opt

-- ----------------------------------------------------------------------------
-- Encoding
-- ----------------------------------------------------------------------------
opt.encoding = "UTF-8"

-- ----------------------------------------------------------------------------
-- File handling
-- ----------------------------------------------------------------------------
opt.autoread  = true   -- reload file when changed externally
opt.hidden    = true   -- allow switching buffers without saving
opt.confirm   = true   -- ask instead of failing on unsaved changes
opt.backup    = false  -- coc.nvim requirement: no backup files
opt.writebackup = false

-- Centralised directories for swap / backup / undo (trailing // → full path)
opt.backupdir = { ".backup/", vim.fn.expand("~/.backup/"), "/tmp//" }
opt.directory = { ".swp/",    vim.fn.expand("~/.swp/"),    "/tmp//" }
opt.undodir   = { vim.fn.expand("~/.undodir/"), "/tmp//" }
opt.undofile  = true   -- persist undo history across sessions

-- Ensure the undo directory actually exists
local undodir = vim.fn.expand("~/.undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p", "0700")
end

-- ----------------------------------------------------------------------------
-- UI
-- ----------------------------------------------------------------------------
opt.number         = true
opt.relativenumber = true
opt.cursorline     = true
opt.ruler          = true
opt.showmode       = false  -- lualine shows the mode already
opt.showcmd        = true
opt.scrolloff      = 8      -- keep 8 lines of context around cursor
opt.signcolumn     = "yes"  -- always show sign column (prevents layout shifts)
opt.title          = true
opt.linebreak      = true   -- wrap at word boundaries, not mid-word
opt.breakindent    = true   -- wrapped lines continue at the same indent level
opt.list           = true
opt.listchars      = { tab = "‣ ", trail = "·", nbsp = "␣" }  -- also reveal non-breaking spaces
opt.splitbelow     = true
opt.splitright     = true   -- vertical splits open to the right (not left)
opt.inccommand     = "split"  -- live preview of :s/old/new substitutions in a split

-- ----------------------------------------------------------------------------
-- Search
-- ----------------------------------------------------------------------------
opt.hlsearch  = true   -- highlight all matches
opt.incsearch = true   -- show matches while typing
opt.ignorecase = true  -- case-insensitive …
opt.smartcase  = true  -- … unless the query has uppercase letters

-- ----------------------------------------------------------------------------
-- Indentation
-- ----------------------------------------------------------------------------
opt.autoindent  = true
opt.smartindent = true
opt.expandtab   = true   -- spaces, not tabs
opt.tabstop     = 2
opt.softtabstop = 2
opt.shiftwidth  = 2
opt.smarttab    = true

-- ----------------------------------------------------------------------------
-- Bells
-- ----------------------------------------------------------------------------
opt.errorbells = false
opt.visualbell = true
opt.belloff    = "all"

-- ----------------------------------------------------------------------------
-- Mouse / clipboard
-- ----------------------------------------------------------------------------
opt.mouse = "a"
-- Defer clipboard setup: initialising the system clipboard (pbcopy/pbpaste on
-- macOS, xclip/wl-copy on Linux) can add ~20-30 ms to startup time.
-- vim.schedule defers it until after the UI is ready.
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- ----------------------------------------------------------------------------
-- Completion / command line
-- ----------------------------------------------------------------------------
opt.wildmenu  = true
opt.wildmode  = "list:longest,full"
opt.shortmess:append("c")  -- suppress ins-completion-menu messages (coc)

-- NOTE: `set path+=**` (recursive subtree search) was removed.
-- It causes severe slowdowns in large projects. fzf/ripgrep handle file
-- finding much more efficiently — use <C-p> (Files) or <leader>s (Rg).

-- ----------------------------------------------------------------------------
-- Performance
-- ----------------------------------------------------------------------------
opt.updatetime  = 100   -- faster CursorHold (diagnostics, highlights)
opt.timeoutlen  = 500   -- ms to wait for mapped sequence to complete

-- ----------------------------------------------------------------------------
-- External tools
-- ----------------------------------------------------------------------------
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --color=never"
  vim.g.rg_derive_root = "true"
  vim.g.rg_highlight   = "true"
end

-- ----------------------------------------------------------------------------
-- Filetype recognition (still needed even with Treesitter)
-- ----------------------------------------------------------------------------
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- netrw — configure before it loads (g:loaded_netrw is set BY netrw, not before)
vim.g.netrw_winsize       = 25
vim.g.netrw_banner        = 1     -- keep the banner (set 0 to hide)
vim.g.netrw_browse_split  = 2     -- open files to the right
vim.g.netrw_altv          = 1
vim.g.netrw_liststyle     = 3     -- tree view
vim.g.netrw_hide          = 0

-- ----------------------------------------------------------------------------
-- Diagnostics (native Neovim — applies alongside coc.nvim's own diagnostics)
-- ----------------------------------------------------------------------------
vim.diagnostic.config({
  update_in_insert = false,           -- don't flash errors while typing
  severity_sort    = true,            -- errors above warnings in lists/floats
  underline        = { severity = vim.diagnostic.severity.ERROR },
  float            = { border = "rounded", source = "if_many" },
  jump             = { float = true }, -- auto-open float when jumping with [d/]d
  virtual_text     = { severity = { min = vim.diagnostic.severity.WARN } },
})
