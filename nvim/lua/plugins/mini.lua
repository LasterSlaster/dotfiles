-- =============================================================================
-- lua/plugins/mini.lua — mini.nvim modules
-- =============================================================================
-- All from echasnovski/mini.nvim (individual module packages).
--
-- Modules configured here:
--   mini.ai          enhanced text objects (a/i variants for f, t, q, b …)
--   mini.align       align text interactively  ga / gA
--   mini.animate     smooth scroll + window open/close animations
--   mini.comment     code commenting  gcc / gc<motion>  (replaces Comment.nvim)
--   mini.cursorword  highlight all occurrences of the word under cursor
--   mini.hipatterns  highlight hex colour codes inline
--   mini.icons       icon provider (nvim-web-devicons shim)
--   mini.indentscope animated indent-scope indicator
--   mini.move        move lines / selections  S-j/S-k visual, M-j/M-k normal
--                    (replaces vim-move)
--   mini.notify      floating notification windows (overrides vim.notify)
--   mini.pairs       smart auto-pairs  (replaces coc-pairs)
--   mini.sessions    session save / restore  (feeds mini.starter)
--   mini.starter     start screen  (replaces vim-startify)
--   mini.statusline  status line  (replaces lualine)
--   mini.surround    surround text  ys / cs / ds  (replaces nvim-surround)
--   mini.tabline     buffer list displayed in the tabline
--   mini.trailspace  highlight trailing whitespace + :lua MiniTrailspace.trim()
--
-- NOT included:
--   mini.completion — blink.cmp is used instead (richer LSP integration)
-- =============================================================================

local not_vscode = function()
	return not vim.g.vscode
end

-- Box a fortune string the same way startify#fortune#boxed() did:
--   ┌──────────────────────┐
--   │ quote line …         │
--   └──────────────────────┘
local function boxed_fortune()
	local raw = vim.fn.system("fortune")
	-- Split into lines, strip leading/trailing blank lines
	local lines = {}
	for line in (raw .. "\n"):gmatch("([^\n]*)\n") do
		lines[#lines + 1] = line
	end
	while #lines > 0 and lines[1]:match("^%s*$") do
		table.remove(lines, 1)
	end
	while #lines > 0 and lines[#lines]:match("^%s*$") do
		table.remove(lines)
	end

	-- Find the widest line
	local width = 0
	for _, l in ipairs(lines) do
		if #l > width then
			width = #l
		end
	end

	-- Build the box
	local box = { "┌" .. string.rep("─", width + 2) .. "┐" }
	for _, l in ipairs(lines) do
		box[#box + 1] = "│ " .. l .. string.rep(" ", width - #l) .. " │"
	end
	box[#box + 1] = "└" .. string.rep("─", width + 2) .. "┘"
	return table.concat(box, "\n")
end

-- ASCII art pool reused by mini.starter's header (keeps the Startify flavour)
local ascii_pool = {
	-- Hypno Toad
	table.concat({
		"     ,'``.._   ,'``._                           ",
		"     :,--._:)\\,:,._,:        All Glory to      ",
		"     :`--,''   :`...';\\      the HYPNO TOAD!   ",
		"      `,'       `---'  `.                       ",
		"      /                 :                       ",
		"     /                   \\                     ",
		"   ,'                     :\\.___,-.            ",
		"  `...,---'``````-..._    |:       \\           ",
		"    (                 )   ;:    )   \\  _,-.    ",
		"     `.              (   //          `'    \\   ",
		"      :               `.//  )      )     , ;    ",
		"    ,-|`.            _,'/       )    ) ,' ,'    ",
		"   (  :`.`-..____..=:.-':     .     _,' ,'      ",
		"    `,'\\ ``--....-)='    `._,  \\  ,') _ '``._ ",
		" _.-/ _ `.       (_)      /     )' ; / \\ \\`-.'",
		"`--(   `-:`.     `' ___..'  _,-'   |/   `.)     ",
		"    `-. `.`.``-----``--,  .'                    ",
		"      |/`.\\`'        ,','); SSt                ",
		"          `         (/  (/                      ",
	}, "\n"),
	-- Abstract art 1
	table.concat({
		"⠀⠀⣀⣀⣤⣤⣦⣶⢶⣶⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⡄⠀⠀⠀⠀⠀",
		"⠀⠀⣿⣿⣿⠿⣿⣿⣾⣿⣿⣿⣿⣿⣿⠟⠛⠛⢿⣿⡇⠀⠀⠀⠀⠀",
		"⠀⠀⣿⡟⠡⠂⠀⢹⣿⣿⣿⣿⣿⣿⡇⠘⠁⠀⠀⣿⡇⠀⢠⣄⠀⠀",
		"⠀⠀⢸⣗⢴⣶⣷⣷⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣴⣿⣗⣄⣼⣷⣶⡄",
		"⠀⢀⣾⣿⡅⠐⣶⣦⣶⠀⢰⣶⣴⣦⣦⣶⠴⠀⢠⣿⣿⣿⣿⣼⣿⡇",
		"⢀⣾⣿⣿⣷⣬⡛⠷⣿⣿⣿⣿⣿⣿⣿⠿⠿⣠⣿⣿⣿⣿⣿⠿⠛⠃",
		"⢸⣿⣿⣿⣿⣿⣿⣿⣶⣦⣭⣭⣥⣭⣵⣶⣿⣿⣿⣿⣟⠉⠀⠀⠀⠀",
		"⠀⠙⠇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀",
		"⠀⠀⠀⣿⣿⣿⣿⣿⣛⠛⠛⠛⠛⠛⢛⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠿⣿⣿⣿⠿⠿⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⠿⠇⠀⠀⠀⠀⠀",
	}, "\n"),
}

return {

	-- --------------------------------------------------------------------------
	-- mini.icons — icon provider (load early; provides nvim-web-devicons shim)
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.icons",
		version = "*",
		lazy = false,
		priority = 1000,
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	-- --------------------------------------------------------------------------
	-- mini.pairs — smart auto-pairs  (replaces coc-pairs)
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "InsertEnter",
		opts = {},
	},

	-- --------------------------------------------------------------------------
	-- mini.ai — enhanced text objects
	--   af / if   function call        aq / iq  any quote
	--   at / it   HTML / JSX tag       ab / ib  any bracket
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.ai",
		version = "*",
		event = "VeryLazy",
		opts = { n_lines = 500 },
	},

	-- --------------------------------------------------------------------------
	-- mini.align — align text interactively
	--   ga   start alignment (choose delimiter interactively)
	--   gA   start with preview
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.align",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	-- --------------------------------------------------------------------------
	-- mini.animate — smooth scrolling + window animations
	-- Scroll animations apply to <C-d>, <C-u>, <C-f>, <C-b> etc.
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.animate",
		cond = not_vscode,
		version = "*",
		event = "VeryLazy",
		config = function()
			local animate = require("mini.animate")
			local timing = animate.gen_timing.linear({ duration = 80, unit = "total" })
			animate.setup({
				scroll = {
					enable = true,
					timing = timing,
				},
				cursor = {
					-- Cursor trail can be distracting; disable if so
					enable = true,
					timing = animate.gen_timing.linear({ duration = 40, unit = "total" }),
				},
				resize = {
					enable = true,
					timing = timing,
				},
				open = { enable = true, timing = timing },
				close = { enable = true, timing = timing },
			})
		end,
	},

	-- --------------------------------------------------------------------------
	-- mini.comment — code commenting  (replaces Comment.nvim; same keymaps)
	--   gcc     toggle comment on current line
	--   gc<motion> / gc in visual mode
	--   gcap    toggle paragraph
	--
	-- nvim-ts-context-commentstring makes mini.comment treesitter-aware so it
	-- picks the correct comment syntax inside embedded languages:
	--   JSX inside .tsx      → {/* */}  not //
	--   <script> inside .vue → //       not <!-- -->
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.comment",
		version = "*",
		event = "VeryLazy",
		-- nvim-treesitter is NOT listed here to avoid overriding its
		-- cond = not_vscode guard; treesitter.lua owns that spec.
		-- ts_context_commentstring is only needed (and loaded) in standalone Neovim.
		dependencies = not vim.g.vscode and {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				-- Disable the built-in autocmd; mini.comment calls the function directly
				opts = { enable_autocmd = false },
			},
		} or nil,
		config = function()
			local opts = {}
			if not vim.g.vscode then
				opts.options = {
					custom_commentstring = function()
						return require("ts_context_commentstring.internal").calculate_commentstring()
							or vim.bo.commentstring
					end,
				}
			end
			require("mini.comment").setup(opts)
		end,
	},

	-- --------------------------------------------------------------------------
	-- mini.cursorword — dim / highlight all occurrences of word under cursor
	-- Complements LSP document-highlight (which is semantic); this works always.
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.cursorword",
		cond = not_vscode,
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		opts = { delay = 200 },
	},

	-- --------------------------------------------------------------------------
	-- mini.hipatterns — highlight patterns inside text
	-- Used here for: inline hex colour preview (replaces ap/vim-css-color)
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.hipatterns",
		cond = not_vscode,
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local hp = require("mini.hipatterns")
			hp.setup({
				highlighters = {
					-- Hex colours: #rrggbb / #rgb  →  coloured background swatch
					hex_color = hp.gen_highlighter.hex_color(),
				},
			})
		end,
	},

	-- --------------------------------------------------------------------------
	-- mini.indentscope — animated indicator for the current indent scope
	-- The scope line animates in from the current cursor position.
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.indentscope",
		cond = not_vscode,
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
			draw = {
				animation = function()
					return 5
				end,
			}, -- 5ms per step
		},
		init = function()
			-- Disable for certain buffer / file types
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"neo-tree",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"ministarter",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- --------------------------------------------------------------------------
	-- mini.move — move lines / selections without cut+paste
	-- Visual mode:  <S-j> / <S-k>    move selection down / up   (was vim-move)
	--               <S-h> / <S-l>    move selection left / right
	-- Normal mode:  <M-j> / <M-k>    move current line down / up
	--               <M-h> / <M-l>    move current line left / right
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.move",
		version = "*",
		event = "VeryLazy",
		opts = {
			mappings = {
				-- Visual-mode: mirrors the old vim-move Shift+J/K behaviour
				left = "<S-h>",
				right = "<S-l>",
				down = "<S-j>",
				up = "<S-k>",
				-- Normal-mode: use Alt to avoid clobbering J (join) and K (man)
				line_left = "<M-h>",
				line_right = "<M-l>",
				line_down = "<M-j>",
				line_up = "<M-k>",
			},
			options = { reindent_linewise = true },
		},
	},

	-- --------------------------------------------------------------------------
	-- mini.notify — floating notification popups (replaces vim.notify)
	-- Messages from lazy.nvim, LSP, etc. will appear as dismissable floats.
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.notify",
		cond = not_vscode,
		version = "*",
		lazy = false, -- must override vim.notify before any plugin can use it
		config = function()
			require("mini.notify").setup({
				window = {
					config = {
						border = "rounded",
					},
					max_width_share = 0.5,
					winblend = 10,
				},
				lsp_progress = { enable = true },
			})
			vim.notify = require("mini.notify").make_notify()
		end,
	},

	-- --------------------------------------------------------------------------
	-- mini.sessions — lightweight session management
	-- Sessions are saved to ~/.config/nvim/session/ (same dir as startify used).
	--   :lua MiniSessions.write("name")   save a named session
	--   :lua MiniSessions.read("name")    restore a session
	--   :lua MiniSessions.delete("name")  delete a session
	-- mini.starter lists available sessions automatically.
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.sessions",
		cond = not_vscode,
		version = "*",
		lazy = false,
		opts = {
			autoread = true, -- restore session on startup if one matches cwd
			autowrite = true, -- save on exit (like startify_session_persistence)
			directory = vim.fn.expand("~/.config/nvim/session"), -- same as startify_session_dir
			file = "Session.vim",
			verbose = { read = false, write = true, delete = true },
		},
	},

	-- --------------------------------------------------------------------------
	-- mini.starter — start screen  (replaces vim-startify)
	-- <leader><tab>   open / close start screen
	--
	-- Sections:
	--   Recent files      (10 entries, relative paths)
	--   Sessions          (5 most recent)
	--   Config shortcuts  (init.lua, notes, dotfiles …)
	--   Commands          (Lazy, Mason, help …)
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.starter",
		cond = not_vscode,
		version = "*",
		lazy = false,
		dependencies = { "echasnovski/mini.sessions" },
		config = function()
			local starter = require("mini.starter")

			-- Fortune box above a random ASCII art piece (mirrors old startify layout)
			local function random_header()
				math.randomseed(os.clock() * 1e6)
				local art = ascii_pool[math.random(#ascii_pool)]
				return boxed_fortune() .. "\n\n" .. art
			end

			starter.setup({
				-- Header: random ASCII art on each open
				header = random_header,

				items = {
					-- 10 most recently used files (relative paths)
					starter.sections.recent_files(10, false, false),

					-- Up to 5 saved sessions
					starter.sections.sessions(5, true),

					-- Config + dotfile shortcuts (mirrors startify_bookmarks)
					{
						{
							name = "init.lua",
							action = "edit ~/.config/nvim/init.lua",
							section = "Config",
						},
						{
							name = "options.lua",
							action = "edit ~/.config/nvim/lua/config/options.lua",
							section = "Config",
						},
						{
							name = "keymaps.lua",
							action = "edit ~/.config/nvim/lua/config/keymaps.lua",
							section = "Config",
						},
						{
							name = "Notes",
							action = "edit ~/OneDrive/notes",
							section = "Config",
						},
						{
							name = ".gitconfig",
							action = "edit ~/.gitconfig",
							section = "Config",
						},
						{
							name = ".bash_aliases",
							action = "edit ~/.bash_aliases",
							section = "Config",
						},
						{
							name = ".bashrc",
							action = "edit ~/.bashrc",
							section = "Config",
						},
					},

					-- Quick commands
					{
						{ name = "New file", action = "enew", section = "Commands" },
						{ name = "Lazy (plugins)", action = "Lazy", section = "Commands" },
						{ name = "Mason (LSP)", action = "Mason", section = "Commands" },
						{ name = "Vim help", action = "help", section = "Commands" },
					},
				},

				-- Content hooks: pad item names to a consistent width
				content_hooks = {
					starter.gen_hook.adding_bullet("» "),
					starter.gen_hook.aligning("center", "center"),
				},

				footer = "",
			})

			-- <leader><tab> toggles the start screen (matches old startify binding)
			vim.keymap.set("n", "<leader><tab>", function()
				if vim.bo.filetype == "ministarter" then
					starter.close()
				else
					starter.open()
				end
			end, { desc = "Toggle start screen" })

			-- Refresh the random header each time the starter is opened
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniStarterOpened",
				callback = function()
					starter.config.header = random_header()
					starter.refresh()
				end,
			})
		end,
	},

	-- --------------------------------------------------------------------------
	-- mini.statusline — statusline  (replaces lualine)
	--
	-- Active line layout (mirrors the old lualine sections):
	--   [mode] [branch  diff  diagnostics] <filename●> = [fileinfo] [search loc]
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.statusline",
		cond = not_vscode,
		version = "*",
		lazy = false,
		config = function()
			local statusline = require("mini.statusline")

			statusline.setup({
				-- Use a single global statusline (vim.o.laststatus = 3)
				set_vim_settings = true,

				content = {
					-- Active window
					active = function()
						local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
						local git = statusline.section_git({ trunc_width = 75 })
						local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
						local lsp_info = statusline.section_lsp({ trunc_width = 75 })
						local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
						local location = statusline.section_location({ trunc_width = 75 })
						local search = statusline.section_searchcount({ trunc_width = 75 })

						-- Relative filename with modification / readonly flags
						local filename = (function()
							local fname = vim.fn.expand("%:.") -- relative to cwd
							if fname == "" then
								fname = "[No Name]"
							end
							if vim.bo.modified then
								fname = fname .. " ●"
							end
							if (not vim.bo.modifiable) or vim.bo.readonly then
								fname = fname .. " "
							end
							return fname
						end)()

						return statusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics, lsp_info } },
							"%<", -- truncation point
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=", -- right-align remainder
							{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
							{ hl = "MiniStatuslineLocation", strings = { search, location } },
						})
					end,

					-- Inactive windows: just the filename
					inactive = function()
						local fname = vim.fn.expand("%:.")
						if fname == "" then
							fname = "[No Name]"
						end
						return statusline.combine_groups({
							{ hl = "MiniStatuslineFilename", strings = { fname } },
						})
					end,
				},
			})

			-- Force global statusline (one bar for all windows)
			vim.opt.laststatus = 3
		end,
	},

	-- --------------------------------------------------------------------------
	-- mini.surround — surround text  (replaces nvim-surround; same ys/cs/ds keys)
	--   ys<motion><char>   add surrounding
	--   cs<old><new>       change surrounding
	--   ds<char>           delete surrounding
	--   gsh                highlight surrounding
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "VeryLazy",
		opts = {
			-- Remap to nvim-surround-compatible keys so muscle memory is preserved
			mappings = {
				add = "ys", -- ys<motion><char>
				delete = "ds", -- ds<char>
				replace = "cs", -- cs<old><new>
				find = "gsf", -- find surrounding (right)
				find_left = "gsF", -- find surrounding (left)
				highlight = "gsh", -- highlight surrounding
				update_n_lines = "gsn", -- change n_lines search range
				suffix_last = "l",
				suffix_next = "n",
			},
			n_lines = 50, -- search up to 50 lines for a surrounding
		},
	},

	-- --------------------------------------------------------------------------
	-- mini.tabline — buffer list rendered in the tabline
	-- Shows open buffers as clickable labels; actual vim tabs on the right.
	-- No extra keymaps needed: <a-o>/<a-i> for buffer cycling still work.
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.tabline",
		cond = not_vscode,
		version = "*",
		lazy = false, -- must set tabline immediately
		opts = {
			show_icons = true,
			set_vim_settings = true, -- sets showtabline=2
			tabpage_section = "right",
		},
	},

	-- --------------------------------------------------------------------------
	-- mini.trailspace — highlight trailing whitespace + trim helper
	--   <leader>tw   trim all trailing whitespace in the buffer
	-- --------------------------------------------------------------------------
	{
		"echasnovski/mini.trailspace",
		cond = not_vscode,
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.trailspace").setup()

			vim.keymap.set("n", "<leader>tw", function()
				require("mini.trailspace").trim()
			end, { desc = "Trim trailing whitespace" })
		end,
	},
}
