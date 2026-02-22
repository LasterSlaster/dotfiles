-- =============================================================================
-- lua/plugins/lsp.lua — Native LSP stack
-- =============================================================================
-- mason.nvim          — LSP server installer (:Mason)
-- nvim-lspconfig      — server definitions (lsp/*.lua files: cmd/filetypes/root_markers)
-- blink.cmp           — completion engine (replaces coc completion)
-- LuaSnip             — snippet engine (replaces coc-snippets)
-- friendly-snippets   — snippet data (replaces honza/vim-snippets)
-- fidget.nvim         — LSP progress UI
-- flutter-tools.nvim  — Dart/Flutter LSP + device picker + hot reload
--
-- Server startup flow:
--   nvim-lspconfig  →  provides lsp/<server>.lua definitions on the runtimepath
--   vim.lsp.config  →  merges capabilities + per-server settings
--   mason-lspconfig →  auto_enable = true calls vim.lsp.enable() for every
--                      Mason-installed server
--
-- Keymaps (buffer-local, active when an LSP server attaches):
--   gd            go to definition
--   gy            go to type definition
--   gi            go to implementation
--   gr            go to references
--   K             hover documentation
--   [g / ]g       previous / next diagnostic
--   <leader>rn    rename symbol
--   <leader>a     code action  (n + x)
--   <leader>af    quickfix for current diagnostic
--   <leader>f     format buffer / selection  (n + x)
--   <leader>cl    code lens action
--   <leader>cdi   diagnostics → quickfix list
--   <leader>co    document symbols (outline)
--   <leader>cs    workspace symbols
--   <leader>ih    toggle inlay hints
--
-- Completion (insert mode):
--   <Tab>         next item / forward snippet placeholder
--   <S-Tab>       prev item / backward snippet placeholder
--   <CR>          confirm selection
--   <C-Space>     show / toggle docs
--   <C-e>         dismiss popup
--   <C-f>         scroll docs down
--   <C-b>         scroll docs up
-- =============================================================================

local not_vscode = function()
	return not vim.g.vscode
end

return {

	-- --------------------------------------------------------------------------
	-- LuaSnip — snippet engine
	-- --------------------------------------------------------------------------
	{
		"L3MON4D3/LuaSnip",
		cond = not_vscode,
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			-- Load VSCode-style snippets from friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	-- --------------------------------------------------------------------------
	-- blink.cmp — fast, Lua-native completion engine
	-- --------------------------------------------------------------------------
	{
		"saghen/blink.cmp",
		cond = not_vscode,
		version = "*",
		dependencies = { "L3MON4D3/LuaSnip" },
		opts = {
			keymap = {
				preset = "none",
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			cmdline = {
				sources = { "cmdline" },
			},
			snippets = { preset = "luasnip" },
			signature = { enabled = true },
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
			},
		},
	},

	-- --------------------------------------------------------------------------
	-- fidget.nvim — LSP progress spinner shown near the statusline
	-- --------------------------------------------------------------------------
	{
		"j-hui/fidget.nvim",
		cond = not_vscode,
		event = "LspAttach",
		opts = {},
	},

	-- --------------------------------------------------------------------------
	-- flutter-tools.nvim — Dart/Flutter LSP + hot reload + device selector
	-- Starts dartls automatically for .dart files; triggers the shared
	-- LspAttach autocmd below for keymaps.
	-- --------------------------------------------------------------------------
	{
		"akinsho/flutter-tools.nvim",
		cond = not_vscode,
		ft = { "dart" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- flutter-tools starts dartls itself outside of mason-lspconfig, so
			-- pass capabilities explicitly; the global vim.lsp.config("*") does not
			-- apply to servers started by third-party plugins.
			require("flutter-tools").setup({
				lsp = {
					capabilities = require("blink.cmp").get_lsp_capabilities(),
				},
			})
		end,
	},

	-- --------------------------------------------------------------------------
	-- mason.nvim — GUI installer for LSP servers, linters, formatters
	-- :Mason to open; :MasonUpdate to upgrade all installed tools
	-- --------------------------------------------------------------------------
	{
		"williamboman/mason.nvim",
		cond = not_vscode,
		cmd = { "Mason", "MasonUpdate", "MasonInstall" },
		build = ":MasonUpdate",
		opts = {},
	},

	-- --------------------------------------------------------------------------
	-- mason-lspconfig — installs servers and enables them via vim.lsp.enable()
	-- automatic_enable = true replaces the old handlers / setup() bridge
	-- --------------------------------------------------------------------------
	{
		"williamboman/mason-lspconfig.nvim",
		cond = not_vscode,
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"html", -- HTML
				"cssls", -- CSS
				"ts_ls", -- TypeScript / JavaScript
				"angularls", -- Angular
				"eslint", -- ESLint (diagnostics + fixes)
				"pyright", -- Python
				"gopls", -- Go
				"jsonls", -- JSON
				"yamlls", -- YAML
				"lemminx", -- XML
				"sqls", -- SQL
				"vimls", -- VimScript
				"bashls", -- Bash / Shell
				"jdtls", -- Java
			},
			-- Calls vim.lsp.enable() for every Mason-managed server automatically.
			-- No explicit vim.lsp.enable() list required.
			automatic_enable = true,
		},
	},

	-- --------------------------------------------------------------------------
	-- nvim-lspconfig — server definitions only (lsp/*.lua: cmd/filetypes/root_markers)
	-- No require("lspconfig").setup() calls; vim.lsp.config() is used instead.
	-- --------------------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		cond = not_vscode,
		-- Must be on the runtimepath before mason-lspconfig's automatic_enable fires
		-- so that vim.lsp.enable() can resolve the server definitions.
		priority = 100,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			-- -----------------------------------------------------------------------
			-- Global defaults — merged into every server config
			-- -----------------------------------------------------------------------
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			-- -----------------------------------------------------------------------
			-- Per-server overrides (only servers that need non-default settings)
			-- -----------------------------------------------------------------------

			-- TypeScript — inlay hints
			vim.lsp.config("ts_ls", {
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayVariableTypeHints = false,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
						},
					},
				},
			})

			-- Go — static analysis + inlay hints
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
						hints = {
							parameterNames = true,
							functionTypeParameters = true,
						},
					},
				},
			})

			-- -----------------------------------------------------------------------
			-- LspAttach — buffer-local keymaps + document-highlight setup
			-- Fires whenever any LSP client (including flutter-tools dartls) attaches.
			-- -----------------------------------------------------------------------
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, silent = true, desc = desc })
					end

					-- Code navigation
					map("gd", vim.lsp.buf.definition, "Go to definition")
					map("gy", vim.lsp.buf.type_definition, "Go to type definition")
					map("gi", vim.lsp.buf.implementation, "Go to implementation")
					map("gr", vim.lsp.buf.references, "Go to references")

					-- Hover documentation
					map("K", vim.lsp.buf.hover, "Show documentation")

					-- Diagnostics navigation
					map("[g", vim.diagnostic.goto_prev, "Previous diagnostic")
					map("]g", vim.diagnostic.goto_next, "Next diagnostic")

					-- Refactoring
					map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map("<leader>a", vim.lsp.buf.code_action, "Code action", { "n", "x" })
					map("<leader>af", function()
						vim.lsp.buf.code_action({
							apply = true,
							context = { only = { "quickfix" }, diagnostics = {} },
						})
					end, "Auto-fix current diagnostic")
					map("<leader>cl", vim.lsp.codelens.run, "Code lens action")

					-- Format buffer / selection (delegates to conform when available)
					map("<leader>f", function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end, "Format buffer/selection", { "n", "x" })

					-- Lists
					map("<leader>cdi", function()
						vim.diagnostic.setqflist()
					end, "Diagnostics → quickfix")
					map("<leader>co", vim.lsp.buf.document_symbol, "Document outline")
					map("<leader>cs", vim.lsp.buf.workspace_symbol, "Workspace symbols")

					-- Inlay hints toggle
					map("<leader>ih", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
							{ bufnr = event.buf }
						)
					end, "Toggle inlay hints")

					-- Document highlight: brighten all references to symbol under cursor
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method("textDocument/documentHighlight") then
						local hl = vim.api.nvim_create_augroup("LspDocHighlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							group = hl,
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd("CursorMoved", {
							group = hl,
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- User command: format whole buffer via LSP
			vim.api.nvim_create_user_command("Format", function()
				vim.lsp.buf.format({ async = true })
			end, {})

			-- User command: organise imports (Go / TypeScript)
			vim.api.nvim_create_user_command("OR", function()
				vim.lsp.buf.code_action({
					apply = true,
					context = { only = { "source.organizeImports" }, diagnostics = {} },
				})
			end, {})
		end,
	},
}
