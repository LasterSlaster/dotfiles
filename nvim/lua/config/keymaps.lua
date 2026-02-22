-- =============================================================================
-- lua/config/keymaps.lua — General key mappings
-- =============================================================================
-- Plugin-specific mappings live in their plugin spec files (lua/plugins/).
-- Only mappings that don't depend on any plugin belong here.
-- =============================================================================

local map = vim.keymap.set

-- Allow saving files as sudo when vim was opened without sudo
vim.cmd("cmap w!! w !sudo tee > /dev/null %")

-- ----------------------------------------------------------------------------
-- Insert mode
-- ----------------------------------------------------------------------------
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- ----------------------------------------------------------------------------
-- Visual mode — indentation (keep selection after indent)
-- ----------------------------------------------------------------------------
map("v", ">",      ">gv",  { desc = "Indent right" })
map("v", "<",      "<gv",  { desc = "Indent left" })
map("v", "<Tab>",  ">gv",  { desc = "Indent right" })
map("v", "<S-Tab>","<gv",  { desc = "Indent left" })

-- ----------------------------------------------------------------------------
-- Normal mode — universal (work in both standalone and VSCode)
-- ----------------------------------------------------------------------------
-- <Esc> in normal mode clears search highlights (zero-thought ergonomics)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- <F3> still available as an explicit toggle if preferred
map("n", "<F3>", ":set hlsearch!<CR>", { desc = "Toggle search highlight" })

-- Paste from yank register (not from delete register)
map("n", "<leader>p", '"0p', { desc = "Paste from yank register" })

-- ----------------------------------------------------------------------------
-- Save / close
-- In VSCode, bypass Neovim's window management and call VSCode commands
-- directly — using :q/:w triggers WinClosed/BufWrite callbacks that fire on
-- a window ID VSCode has already freed, causing "Invalid window id" errors.
-- In standalone Neovim, keep the familiar :w/:q.
-- ----------------------------------------------------------------------------
if vim.g.vscode then
  map("n", "<leader>q", "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>",
    { desc = "Close editor" })
  map("n", "<leader>w", "<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>",
    { desc = "Save file" })
else
  map("n", "<leader>q", ":q<CR>", { desc = "Close window" })
  map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
end

-- ----------------------------------------------------------------------------
-- Normal / non-VSCode mappings
-- (VSCode manages its own window/buffer/tab UI)
-- ----------------------------------------------------------------------------
if not vim.g.vscode then
  -- Window navigation — <C-hjkl> (one keypress, community standard)
  -- <leader>hjkl kept as well for muscle memory during transition
  map("n", "<C-h>", "<C-w><C-h>", { desc = "Window left" })
  map("n", "<C-j>", "<C-w><C-j>", { desc = "Window down" })
  map("n", "<C-k>", "<C-w><C-k>", { desc = "Window up" })
  map("n", "<C-l>", "<C-w><C-l>", { desc = "Window right" })
  map("n", "<leader>h", ":wincmd h<CR>", { silent = true, desc = "Window left" })
  map("n", "<leader>j", ":wincmd j<CR>", { silent = true, desc = "Window down" })
  map("n", "<leader>k", ":wincmd k<CR>", { silent = true, desc = "Window up" })
  map("n", "<leader>l", ":wincmd l<CR>", { silent = true, desc = "Window right" })

  -- Window resize
  map("n", "<leader>+", ":vertical resize +5<CR>", { silent = true, desc = "Widen window" })
  map("n", "<leader>-", ":vertical resize -5<CR>", { silent = true, desc = "Narrow window" })

  -- Buffer management
  map("n", "<leader>n", ":vnew<CR>",  { desc = "New vertical split" })
  map("n", "<leader>N", ":enew<CR>",  { desc = "New buffer" })

  -- Buffer cycle (alt+o/i mirrors ctrl+o/i for jump list)
  map("n", "<a-o>", ":bn<CR>", { silent = true, desc = "Next buffer" })
  map("n", "<a-i>", ":bp<CR>", { silent = true, desc = "Previous buffer" })

  -- Tab navigation
  for i = 1, 9 do
    map("n", "<leader>" .. i, ":tabnext " .. i .. "<CR>",
      { silent = true, desc = "Go to tab " .. i })
  end

  -- Change working directory to the location of the current file
  map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { desc = "cd to current file" })

  -- Format inner word: first letter uppercase, rest lowercase
  map("n", "<leader>fiw", function()
    vim.cmd("normal guiw~e")
  end, { silent = true, desc = "Capitalise inner word" })

  -- User commands
  vim.api.nvim_create_user_command("MakeTags",     "!ctags -R .",              {})
  vim.api.nvim_create_user_command("Reloadvimrc",  "source ~/.config/nvim/init.lua", {})
end
