# Neovim Setup Documentation

---

## Quick-reference: most important keybindings

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<C-p>` | Fuzzy file search |
| `<leader>s` | Ripgrep project search |
| `<leader>e` | Toggle file explorer |
| `<leader>,` | Toggle terminal |
| `<leader>gg` | Open lazygit |
| `<leader>gs` | Git status (fugitive) |
| `<leader>gws` | Switch git worktree (fzf) |
| `<leader>gwc` | Create git worktree |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>a` | Code action |
| `<leader>f` | Format buffer |
| `[g` / `]g` | Previous / next diagnostic |
| `<leader><tab>` | Toggle start screen |
| `jk` | Exit insert mode |
| `<Esc>` | Clear search highlights (normal mode) |
| `<Tab>` | Next completion / snippet placeholder |
| `gcc` | Toggle comment |
| `am`/`im`, `ac`/`ic` | Treesitter: select function / class |
| `]m` / `[m`, `]]` / `[[` | Treesitter: jump to next/prev function or class |

---

## Part 1 — Installing on a new machine

### 1. System requirements

macOS with Homebrew. Install Homebrew if not present:
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Neovim and core tools

```sh
brew install neovim
brew install git
brew install node          # required by many LSP servers
brew install go            # required by gopls (Go LSP) and sqls (SQL LSP)
brew install fd            # fast file finder used by fzf
brew install ripgrep       # rg — used by project search and fzf preview
brew install bat           # syntax-highlighted file preview in fzf
brew install lazygit       # floating git UI (<leader>gg)
brew install fortune       # random quotes on the start screen
brew install stylua        # Lua formatter
brew install shfmt         # Shell formatter
brew install ctags         # tag generation (:MakeTags)
```

Java 17+ is required by the Java LSP (jdtls). Install via SDKMAN (recommended) or Homebrew:
```sh
# via SDKMAN:
curl -s "https://get.sdkman.io" | bash
sdk install java 17.0.2-tem

# or via Homebrew:
brew install --cask temurin@17
```

### 3. Install Node-based formatters

```sh
npm install -g @fsouza/prettierd   # fast prettier daemon (JS/TS/CSS/HTML/JSON)
npm install -g yarn                # required for markdown-preview build step
```

### 4. Install Python formatter

```sh
pip3 install black
# or via Homebrew:
brew install black
```

### 5. Clone the config

```sh
git clone <your-repo-url> ~/.config/nvim
```

If migrating manually, copy the directory:
```sh
cp -r /path/to/nvim ~/.config/nvim
```

### 6. First launch — let lazy.nvim bootstrap

Open Neovim:
```sh
nvim
```

On the very first launch lazy.nvim will:
1. Clone itself into `~/.local/share/nvim/lazy/lazy.nvim`
2. Install all plugins (~40 packages)
3. Show a progress UI — wait for it to finish, then press `q`

### 7. Install LSP servers via Mason

Inside Neovim:
```
:Mason
```

All configured servers install automatically. Verify the following are installed (press `i` on any that show as not installed):
- `html`, `cssls`, `ts_ls` (TypeScript), `angularls`, `eslint`
- `pyright` (Python), `gopls` (Go), `bashls`, `vimls`
- `jsonls`, `yamlls`, `lemminx` (XML), `sqls` (SQL)
- `jdtls` (Java), `dartls` (Dart/Flutter via flutter-tools)

If gopls or sqls fail, ensure `go` is in `$PATH`:
```sh
which go   # should print /opt/homebrew/bin/go or similar
```

### 8. Install Treesitter parsers

```
:TSUpdate
```

### 9. Build markdown-preview

```
:Lazy build markdown-preview.nvim
```

This runs `cd app && npx --yes yarn install` inside the plugin directory.

### 10. Verify formatters

Open a Lua file and run:
```
:ConformInfo
```
All configured formatters for the current filetype should appear as "ready".

---

## Part 2 — Features and keybindings

### Leader key

The leader key is **`<Space>`**.

---

### Start screen (mini.starter)

| Key | Action |
|-----|--------|
| `<leader><tab>` | Open / close start screen |

On the start screen, sections shown:
- Recent files (10 entries)
- Saved sessions (5 most recent)
- Config shortcuts (init.lua, keymaps.lua, notes, dotfiles)
- Commands (New file, Lazy, Mason, Vim help)

---

### File navigation (fzf)

| Key | Action |
|-----|--------|
| `<C-p>` | Fuzzy file search (fd / rg) |
| `<leader>s` | Ripgrep project search |
| `<leader>/` | Search lines in current buffer |
| `<leader>b` | Open buffer list |
| `<leader>H` | File history (recently opened) |
| `<C-x><C-f>` | Path completion in insert mode |

---

### File explorer (neo-tree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `a` | Create file / directory |
| `d` | Delete |
| `r` | Rename |
| `c` / `m` | Copy / move |
| `y` | Copy path to clipboard |
| `p` | Paste |
| `H` | Toggle hidden files |
| `R` | Refresh |
| `/` | Fuzzy find in tree |
| `<BS>` | Navigate up one directory |
| `s` / `S` | Open in horizontal / vertical split |
| `<CR>` | Open file |
| `q` | Close explorer |

---

### Windows and buffers

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows |
| `<leader>h/j/k/l` | Move between windows (alternative) |
| `<leader>+` / `<leader>-` | Widen / narrow window |
| `<leader>n` | New vertical split |
| `<leader>N` | New empty buffer |
| `<leader>q` | Close window |
| `<leader>w` | Save file |
| `<a-o>` / `<a-i>` | Next / previous buffer |
| `<leader>1`–`9` | Go to tab 1–9 |
| `<leader><leader>` | Interactive window picker (nvim-window) |
| `<C-W><C-M>` | Enter Win-Move mode (winshift) |
| `<C-W>x` | Swap two windows |

---

### Terminal (toggleterm)

| Key | Action |
|-----|--------|
| `<leader>,` | Toggle floating terminal |
| `<leader>gg` | Toggle lazygit in floating terminal |
| `,q` | Hide terminal (terminal mode) |
| `,<space>` | Toggle terminal (terminal mode) |
| `<A-]>` | Send literal Esc to the running program |

---

### LSP — code navigation

Server management uses the Neovim 0.11 native API (`vim.lsp.config` / `vim.lsp.enable`).
Mason installs servers; mason-lspconfig enables them automatically via `automatic_enable = true`.
nvim-lspconfig is present only as a data source for server definitions (`cmd`, `filetypes`, `root_markers`).

These keymaps are active in any buffer where an LSP server has attached.

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `K` | Hover documentation |
| `[g` / `]g` | Previous / next diagnostic |
| `<leader>rn` | Rename symbol |
| `<leader>a` | Code action (normal + visual) |
| `<leader>af` | Auto-fix current diagnostic |
| `<leader>cl` | Code lens action |
| `<leader>f` | Format buffer / selection |
| `<leader>cdi` | Send diagnostics to quickfix list |
| `<leader>co` | Document symbols (outline) |
| `<leader>cs` | Workspace symbols |
| `<leader>ih` | Toggle inlay hints |

User commands:
- `:Format` — format whole buffer via LSP
- `:OR` — organise imports (Go / TypeScript)

---

### Completion (blink.cmp)

Active in insert mode whenever the completion popup is visible.

| Key | Action |
|-----|--------|
| `<Tab>` | Next completion item / forward snippet placeholder |
| `<S-Tab>` | Previous item / backward snippet placeholder |
| `<CR>` | Confirm selection |
| `<C-Space>` | Trigger completion / show docs |
| `<C-e>` | Dismiss popup |
| `<C-f>` | Scroll documentation down |
| `<C-b>` | Scroll documentation up |

---

### Git

| Key | Action |
|-----|--------|
| `<leader>gs` | Git status (fugitive `:G`) |
| `<leader>gc` | Git checkout branch (fzf) |
| `<leader>gb` | List git branches (fzf) |
| `]c` / `[c` | Next / previous hunk |
| `<leader>ghs` | Stage hunk (normal + visual) |
| `<leader>ghu` | Reset/undo hunk (normal + visual) |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Blame current line (full popup) |
| `<leader>gws` | Switch worktree (fzf picker) |
| `<leader>gwc` | Create worktree (prompts for branch + path) |
| `<leader>gwd` | Delete worktree (fzf picker, confirms before delete) |

#### Git worktrees

Git worktrees let you check out multiple branches simultaneously into separate
directories — useful for working on a feature branch while keeping main always
available for quick comparisons or hotfixes.

`<leader>gwc` prompts for a branch name and directory (defaulting to
`../<branch>` next to the current repo root), then creates the worktree and
checks out the branch. `<leader>gws` opens an fzf picker showing all existing
worktrees; selecting one switches Neovim's working directory to it.
`<leader>gwd` opens the same picker but deletes the selected worktree after
a `y/N` confirmation.

Inline blame virtual text appears automatically at the end of the current line after 500 ms (always-on, no keypress required). Provided by gitsigns — no separate plugin needed.

Commands:
- `:GV` — commit browser (all commits)
- `:GV!` — commits for current file
- `:GV?` — revisions of current file → quickfix

---

### Editing motions

| Key | Action |
|-----|--------|
| `s<c1><c2>` | Sneak: jump to next occurrence of two characters |
| `w` / `b` / `e` / `ge` | CamelCase-aware word motions |
| `cx<motion>` | Mark region for exchange |
| `cxx` | Mark current line for exchange |
| `cx<motion>` (second) | Swap with previously marked region |
| `X` (visual) | Swap with previously marked region |

---

### Surround (mini.surround — same keys as vim-surround)

| Key | Action |
|-----|--------|
| `ys<motion><char>` | Add surrounding |
| `cs<old><new>` | Change surrounding |
| `ds<char>` | Delete surrounding |
| `gsh` | Highlight surrounding |

Examples: `ysiw"` wraps word in quotes, `cs"'` changes `"` to `'`, `ds(` removes parentheses.

---

### Move lines (mini.move)

| Key | Mode | Action |
|-----|------|--------|
| `<S-j>` / `<S-k>` | Visual | Move selection down / up |
| `<S-h>` / `<S-l>` | Visual | Move selection left / right |
| `<M-j>` / `<M-k>` | Normal | Move current line down / up |
| `<M-h>` / `<M-l>` | Normal | Move current line left / right |

---

### Commenting (mini.comment)

| Key | Action |
|-----|--------|
| `gcc` | Toggle comment on current line |
| `gc<motion>` | Toggle comment on motion (e.g. `gcap` = paragraph) |
| `gc` (visual) | Toggle comment on selection |

Treesitter-aware: uses the correct comment syntax inside embedded languages (JSX in TSX, `<script>` in Vue, etc.).

---

### Text objects (mini.ai)

Extends the standard `a`/`i` pairs. Use with any operator (`d`, `c`, `y`, `v`).

| Object | Selects |
|--------|---------|
| `af` / `if` | Function call (including arguments) |
| `at` / `it` | HTML / JSX tag |
| `aq` / `iq` | Any quote (`'`, `"`, `` ` ``) |
| `ab` / `ib` | Any bracket (`(`, `[`, `{`) |
| Standard `a(`/`i(`, `a[`/`i[`, `a{`/`i{` | Enhanced with multi-line support |

---

### Text objects (nvim-treesitter-textobjects)

Syntax-aware text objects and motions; work in any language with a treesitter parser (e.g. Dart, Lua, Python, Go, TS).

| Key | Mode | Action |
|-----|------|--------|
| `am` / `im` | Visual / Operator | Select a function (outer) / inner function |
| `ac` / `ic` | Visual / Operator | Select a class (outer) / inner class |
| `]m` / `[m` | Normal / Visual / Operator | Next / previous function start |
| `]]` / `[[` | Normal / Visual / Operator | Next / previous class start |
| `<leader>a` / `<leader>A` | Normal | Swap parameter with next / previous |
| `;` / `,` | Normal / Visual / Operator | Repeat last move forward / backward |

Note: `<leader>a` is also used for LSP code action; the last-loaded mapping wins. Use `:Lazy` to see load order, or change one binding if you need both.

---

### Align (mini.align)

| Key | Action |
|-----|--------|
| `ga` (normal / visual) | Start interactive alignment |
| `gA` | Start alignment with live preview |

After triggering: type the delimiter character (e.g. `=`, `:`, `,`) to align.

---

### Yank ring (yanky.nvim)

| Key | Action |
|-----|--------|
| `p` / `P` | Paste after / before (tracked in ring) |
| `gp` / `gP` | Paste and keep cursor after pasted text |
| `]p` | Cycle forward through yank history (after paste) |
| `[p` | Cycle backward through yank history (after paste) |
| `<leader>p` | Paste from yank register (ignores delete register) |

---

### Formatting (conform.nvim)

| Key | Action |
|-----|--------|
| `<leader>cf` | Format buffer (explicit conform trigger) |
| `<leader>f` | Format buffer / selection (LSP-aware) |
| `<leader>tw` | Trim trailing whitespace |

Format-on-save is active for: Lua, JS, TS, JSON, CSS, HTML, Python, Go, Shell.
Command: `:ConformInfo` — shows active formatters for the current buffer.

---

### Sessions (mini.sessions)

Sessions are saved to `~/.config/nvim/session/`.

| Command | Action |
|---------|--------|
| `:lua MiniSessions.write("name")` | Save a named session |
| `:lua MiniSessions.read("name")` | Restore a session |
| `:lua MiniSessions.delete("name")` | Delete a session |

Sessions are listed on the start screen. The last session for the current working directory is restored automatically on startup.

---

### Persistent text highlighting (HighStr)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>h` | Visual | Highlight selection (up to 9 colour groups) |
| `<leader>H` | Visual | Remove highlight |

---

### Undo history (undotree)

| Key | Action |
|-----|--------|
| `<leader>u` | Open visual undo history browser |

---

### Cheat.sh

| Key | Action |
|-----|--------|
| `<leader>KB` | Look up explanation for last error |
| `<leader>KE` | Search for error message |

Command: `:HowIn javascript` — search for the JS equivalent of the current line.

---

### Miscellaneous

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `<Esc>` | Clear search highlights (normal mode) |
| (automatic) | Relative line numbers in normal mode, absolute in insert / unfocused (nvim-numbertoggle) |
| `<F3>` | Toggle search highlight |
| `>` / `<Tab>` (visual) | Indent right, keep selection |
| `<` / `<S-Tab>` (visual) | Indent left, keep selection |
| `<leader>cd` | Change working directory to current file's location |
| `<leader>fiw` | Capitalise inner word (first letter upper, rest lower) |

Commands:
- `:MakeTags` — run ctags recursively
- `:Reloadvimrc` — reload `init.lua`
- `w!!` — save file with sudo

---

### Plugin management

| Command | Action |
|---------|--------|
| `:Lazy` | Open lazy.nvim plugin manager |
| `:Lazy sync` | Install / update / clean all plugins |
| `:Lazy update` | Update all plugins |
| `:Mason` | Open Mason LSP server manager |
| `:MasonUpdate` | Update all Mason-installed tools |
| `:TSUpdate` | Update all Treesitter parsers |
| `:ConformInfo` | Show active formatters for current buffer |

---

## File structure

```
~/.config/nvim/
├── init.lua                     entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua             lazy.nvim bootstrap
│   │   ├── options.lua          vim options (set …)
│   │   ├── keymaps.lua          general keymaps
│   │   └── autocmds.lua         autocommands
│   └── plugins/
│       ├── coding.lua           editing motions, snippets, yank ring
│       ├── explorer.lua         neo-tree file explorer
│       ├── git.lua              fugitive, gitsigns, gv
│       ├── lang.lua             language-specific plugins (Dart)
│       ├── lsp.lua              LSP stack (mason, vim.lsp.config, blink.cmp, LuaSnip)
│       ├── mini.lua             all mini.nvim modules
│       ├── tools.lua            fzf, toggleterm, conform, undotree, winshift
│       ├── treesitter.lua       nvim-treesitter, context, textobjects
│       └── ui.lua               colorscheme, which-key, numbertoggle
└── SETUP.md                     this file
```
