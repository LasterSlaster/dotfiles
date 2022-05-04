" ---------------------------------------------------------------------------
" INSTALLATION:
" ---------------------------------------------------------------------------
" Follow these instructions to setup this vimrc configuration for a new
" machine and make sure that all dependencies to system programms are
" installed.
"
" - Install neovim nightly/unstable release(>v0.5)
" - Install bat
" - Install lazygit:
"	  - If lazygit is integrated in floaterm plugin and active you have to install
"	  - lazygit from https://github.com/jesseduffield/lazygit
"	- Install ag/rg/ripgrep/fd
"	- CoC Installation
" - install ctags with: sudo apt install universal-ctags
" - run :checkhealth
" - Install languages for treesitter with :TSInstall [language]
" - For latex install latexmk, texlive + extensions{ texlive, texlive-fonts-extra, texlive-math-extra, texlive-lang-dutch (or texlive-lang-european), texlive-lang-english, texlive-latex-extra, texlive-xetex, biber, texlive-science, texlive-latex-extra, texlive-bibtex-extra, texlive-extra-utils} and a pdf preview
"   supporting synctex like zathura
" - install xclip on linux to share system clipboard with neovim
"
" Initialize plugin system:
"	 Reload .vimrc and :PlugInstall to install plugins. See https://github.com/junegunn/vim-plug
"	 To uninstall a plugin remove its line reload vim and run :PlugClean. To update a plugin
"	 run : PlugUpdate. To upgrade plug itself run :PlugUpgrade
"	 Specify directory for plugins
"
" ---------------------------------------------------------------------------
" NOTES:
" ---------------------------------------------------------------------------
"  - Move between tabs with h and l keybinding combination
"  - Automatic project creation
"  - Templates(file creation) for e.g. notes(see obsidian), classes etc.
"  - Replace search tool for / and ? to make it work with fuzzy search
"  - Improve setup to emulate important obsidian features, find tags and
"  navigate links
"  - Fix latex setup and checkout coc-vimtex as an alternative
"  - Checkout LunarVim, AstroVim
"  - Checkout modern terminal emulators like Kitty, Alacritty, Fish, WezTerm,
"  iTerm
"  - Setup vimrc also for root user
"  - Add checks around each plugin installation and configuration to ensure
"  functionaly in every environment
"  - GUI or Plugin(keybindings) to easily split and move windows 
"  - Autocomplete in vim command line / show options -> Look for a fzf list with all vim (:Commands)/ coc commands
"  - Configure neovim for all my dev environments and process. GIt process
"  - Auto formatting and indentation? -> coc?
"  - Coc configuration: Checkout coc-git, coc-python is not maintained anymore
"  replace with coc-pylsp or coc-jedi?
"  - Install and use watchman for automating tasks on file changes?
"  - Improve Startify config
"  - Checkout vim build-in sessions :mksession
"  - https://catswhocode.com/vim-commands/
"
" ---------------------------------------------------------------------------
" COMMANDS:
" ---------------------------------------------------------------------------
" - Relmad vimrc commands: ":so $MYVIMRC" or ":source ~/.vimrc" or ":so %"
" - :CocCommand markdown-preview-enhanced.openPreview
" - :CocCommand flutter.run
" - :CocList FlutterDevices/-Emulators/-Devices
" - :Plug...
" - :Coc...":CocConfig
" - :S... like SLoad to load a Startify session
" - :mksession "Save a vim session
" - :nohlsearch
" - :cd %:p:h "Change working directory to directory of current file
" - :source ~/.vimrc / %
" - :sav filename	"Saves file as filename
" - :50 "Move to line number 50
" - :tab ball	"Puts all open files in tabs
" - :tabnew [filename] "Open file in new tab
" - :args "list files
" - :1,10 w outfile	"Saves lines 1 to 10 in outfile
" - :1,10 w >> outfile	"Appends lines 1 to 10 to outfile
" - :r infile	"Insert the content of infile
" - :23r infile	"Insert the content of infile under line 23
" - :%s/\<./\u&/g	"Sets first letter of each word to uppercase
" - :%s/old/new/gc	"Replace all occurences with confirmation
" - :%s/onward/forward/gi	"Replace onward by forward, case unsensitive
"   :g/string/d	"Delete all lines containing string
" - :v/string/d	"Delvete all lines containing which didn’t contain string
" - :s/Bill/Steve/	"Replace the first occurence of Bill by Steve in current line
" - :s/Bill/Steve/g	"Replace Bill by Steve in current line
" - :%s/Bill/Steve/g	"Replace Bill by Steve in all the file
" - :HowIn [language] "Cheat-vim: search for howto for current line
" - :GV "Git commit browser
" - :g/todo/ "Comment all lines with todo in it
" - :Reloadvimrc "Trys to source vimrc from ~/.vimrc
" - :Format "Format current buffer
" - :Fold "Fold current buffer
" - :OR "Organize imports
" - :Colors "Fzf Command to display vim colorschemes
" - :GFiles? "Fzf Command to display Git files (git status)
" - :BLines [QUERY] 	"Fzf Command to search for text in Lines in the current buffer
" - :Lines [QUERY] 	"Fzf Command to search for text in Lines 
" - :History 	"Fzf command to display v:oldfiles and open buffers
" - :History: 	"Fzf Command to display Command history
" - :History/ 	"Fzf Command to display Search history
" - :Snippets 	"Fzf Command to display Snippets (UltiSnips)
" - :BCommits 	"Fzf Command to display Git commits for the current buffer; visual-select lines to track changes in the range
" - :Commands 	"Fzf Command to display Vim Commands
" - :Maps 	"Fzf Command to display Normal mode mappings
" - :Helptags 	Help tags 1
" - :map / :map!  "Display a list of all key mappings/bindings. ! displays
"   mappings for insert and command mode
"
" - set spell /nospell "Spell checking
"
" - § "Currently maped to all ultisnips keybindings to move it out of the way.
"   Maybe think about a better solution to disable all ultisnips keybindungs
" - * # "Search for word under cursor
" - 50% "type 50% to move to line at 50% of file
" - %	"Move cursor to matching parenthesis
" - ? "In coc-explorer view shows keybindings for file explorer actions
" - [[	"Jump to function start
" - [{	"Jump to block start
" - * "Search for word under cursor
" - =%	"Indent the code between parenthesis
" - gt "Move to next tab or use <Ctlr>+<pageup>/<pagedown>
" - gf "Open file name under cursor
" - Vu	"Lowercase line
" - VU	"Uppercase line
" - g~~	"Invert case
" - vEU	"Switch word to uppercase
" - vE~	"Modify word case
" - ggguG	"Set all text to lowercase
" - gggUG	"Set all text to uppercase
" - Ctrl+a	"Increment number under the cursor
" - Ctrl+x	"Decrement number under cursor
" - <esc><esc> "Cloase floaterm
" - <A-]> "Send <esc> key to program in terminal
" - <C-t> "Open new terminal session in floaterm
" - <C-n> "Switch between floaterm tabs
"   session. When open close window.
" - ys[motion][character] "Surround a motion with a character
" - cs[motion][character] "Replace a character around a motion
"   ds[motion][character] "Deleta a character around a motion
" - gc "In visual mode toggels commenting of highlighted region
" - gcc "Toggle commenting a line
" - gcap "Toggle commenting a paragraph
" - gcgc "Uncomment block
" - cx[motion] "Exchange two motions with each other. cxx to replace two lines
" - <F3> "Toggle highlight search
" - w!! "Sudo write
" - jk "Remapping for <ESC>
" - <C-p> "Search all project files
" - <c-space> "Trigger auto-completion
" - [g and ]g "Navigate diagnostics
" - gd "<Plug>(coc-definition)
" - gy "<Plug>(coc-type-definition)
" - gi "<Plug>(coc-implementation)
" - gr "<Plug>(coc-references)
" - <C-f> "Scroll forward in coc window
" - <C-b> "Scroll backwards in coc window
" - K  "Show documentation
" - <leader>KB or <leader>KE "Cheat-vim search for last error
" - <leader>; "Toggle floaterm window. Open if existing otherwise create a new
" - <leader>u "Open undotree
" - <leader><tab> "Open Startify
" - [c and]c "Git-Gutter: Jump between hunks. Preview, stage, undo <leader>ghp/ghs/ghu. :wincmd P jump to preview window
" - zh "Only in coc-explorer. Shows hidden files
" - Il / Ic "Coc-explorer: Toggle display of file information and content
" ????? inoremap <expr> <c-x><c-f> fzf#vim#complete#path( \ fzf#wrap({'dir': expand('%:p:h')}))
" ---------------------------------------------------------------------------


" install plugin manager vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')
	" Section of plugins to install 
	Plug 'machakann/vim-highlightedyank' "highlights the yanked section for a second
	Plug 'tommcdo/vim-exchange' "Exchange/replace two regions of text with each other. Binding is cx plus movement(cxx=line)
	Plug 'tpope/vim-commentary' "Comment multiple lines. Binding is gc (gcc=line, gcap=paragraph,:g/todo/Commentary=all lines with todo in it,gcgc=uncomment)
	Plug 'morhetz/gruvbox' "Color scheme
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' } "Color scheme
	Plug 'joshdick/onedark.vim' "Color scheme
	Plug 'tpope/vim-fugitive' "Git plugin
	Plug 'junegunn/gv.vim' "Git commit browser. Command is :GV !/? or show changes of selected lines
	Plug 'tpope/vim-surround' " quickly edit surroundings (brackets, html tags, etc) -> ys[motion][character] to surround a motion with a character or cs[motion][character] to replace them with another one and ds to delete surrounding characters 
	Plug 'mbbill/undotree' "Shows a history of all changes in the file as a tree. Binds to <leader>u
	Plug 'dbeniamine/cheat.sh-vim' "Browse code snippets etc. from cheat.sh website. Binding is <leader>KB or <leader>KE to search for last error. Also :HowIn javascrip will search for javascript version of current line
  Plug 'SirVer/ultisnips' "Code snippets. Compare with cheat.sh-vim. Also used in fzf and coc
  Plug 'honza/vim-snippets' "Provides snippets for ultisnips
	if has('nvim')
		Plug 'neoclide/coc.nvim', {'branch': 'release'} "An alternative/addition to YouCompleteMe + a lot
    "For more coc extensions checkout https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
    " For coc-metals(scala) installation see https://scalameta.org/metals/docs/editors/vim.html ':CocInstall coc-metals', coc-java, coc-html, coc-tsserver, coc-python, coc-snippets(coc-ultisnips, coc-neosnippet), coc-angular, coc-css, coc-markdownlint, coc-sql, coc-tabnine, coc-xml, coc-yaml, coc-calc, coc-diagnostic, coc-eslint/rome/prettier, coc-highlight, coc-sh, coc-pairs, coc-explorer, coc-flutter, coc-rome(instead/addition to coc-tsserver?), coc-spell-checker, coc-json
	endif
  Plug 'dart-lang/dart-vim-plugin'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "An alternative to ctrlp fuzzy finder. Also install ag and ripgrep on your system
	Plug 'junegunn/fzf.vim' " Wrappers and commands for fzf in vim
	Plug 'stsewd/fzf-checkout.vim' " fzf for git branch management
	Plug 'justinmk/vim-sneak' "Simple two character movements. Binds to s with first two letters of search
	Plug 'vim-airline/vim-airline' "Bottom status bar
	Plug 'mhinz/vim-startify' " Displays recent files on vim startup
	Plug 'liuchengxu/vim-which-key' "Show current key bindings
	Plug 'bkad/CamelCaseMotion'
	Plug 'voldikss/vim-floaterm' "An alternative would be akinsho/toggleterm.nvim or kassio/neoterm
	Plug 'matze/vim-move' "Move lines and blocks of code
  Plug 'airblade/vim-gitgutter' "Alternative to vim-signify. Show git signs in your code
  Plug 'ap/vim-css-color' "CSS color preview
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'romgrk/nvim-treesitter-context' "Always show upper line of outer block context
  Plug 'https://gitlab.com/yorickpeterse/nvim-window.git'
  Plug 'sindrets/winshift.nvim'

  " Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
  " " Plug 'ryanoasis/vim-devicons' Icons without colours
  " Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
  "Plug 'wellle/context.vim' "An alternative to nvim-treesitter-context
  "Plug 'ryanoasis/vim-devicons' "Icons for explorer. Nerdfont. set encoding=utf-8
	"Plug 'easymotion/vim-easymotion' Alternative to vim-sneak
	"Plug 'Valloric/YouCompleteMe' " Also run './install.py --ts-completer --java-completer'. Currently disabled because of incompatibility with coc plugin
	"Plug 'codota/tabnine-vim' " Code completion ai. Builds on top of YouCompleteMe plugin. Coc integration with coc-tabnine extenstion 
	"Plug 'ctrlpvim/ctrlp.vim' " An alternative would be fzf
	"Plug 'Raimondi/delimitMate' "Automatic closing of quotes etc. Currently disabled in favor of coc-pairs
  "Plug 'lyuts/vim-rtags' "Probably I don't need this anymore
	"Plug 'metakirby5/codi.vim' a scratchpad for hackers. REPL
	"Plug 'kassio/neoterm' "Terminal plugin. Integrate into to floaterm and use instead of default terminal?
	"Plug 'nvim-lua/plenary.nvim' "Required for telescope plugin
	"Plug 'nvim-telescope/telescope.nvim' "A fuzzy finder. Alternative to fzf? Requires version 0.6 but I have 0.4...
  "if has('nvim') || has('patch-8.0.902') Plug 'mhinz/vim-signify' else Plug 'mhinz/vim-signify', { 'branch': 'legacy' } endif
	"Plug 'iberianpig/tig-explorer.vim' "Git integration. Alternative to fugitive?
	"Plug 'rbgrouleff/bclose.vim' "Required for tig-explorer in neovim
	"Plug 'jremmen/vim-ripgrep' "Also 'apt install ripgrep'?
	"Plug 'mileszs/ack.vim' "A search tool. Could be used in addition with fd command
  "
  "Plug 'mcchrish/nnn.vim' File explorer
  "Plug 'vifm/vifm.vim' "File explorer. Or use floaterm wrapper
	"Plug 'preservim/nerdtree' an alternative file explorer to the default netrw Or look for a better option. maybe one that integrates into floaterm!
	"Plug 'justinmk/vim-dirvish' another file explorer but very lightweight
	"Plug 'francoiscabrol/ranger.vim' "Plug 'rbgrouleff/bclose.vim' Required for ranger plugin in nvim! File Explorer. Or try floaterm integration
  "
	"Plug 'junegunn/vim-easy-align' " Format hunks of code by row
	"Plug 'sbdchd/neoformat' "Code formatting
	"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "Extended code highlighting
	"Plug 'puremourning/vimspector' "Debugger
	"Plug 'mfussenegger/nvim-dap' Debugger Adapter Protocol
	"Plug 'janko/vim-test' "Vim test runner
call plug#end()


" ---------------------------------------------------------------------------
" CUSTOM CONFIG:
" ---------------------------------------------------------------------------
	" Read file changes if open files have been changed by another program e.g. git pull
  set encoding=UTF-8
	set autoread
	set autoindent
	set splitbelow
	" not act like vi
	set nocompatible
	" set relative line numbers on the left side of the screen + current line
	" number
	set relativenumber number
	" Highlight all search results
	set hlsearch
	" Ignore case in search
	set ignorecase
	" Show search results as yout type
	set incsearch
	set belloff=all
	" Tab settings
	set expandtab
	set tabstop=2 softtabstop=2
	set shiftwidth=2
	set smarttab
	" Auto indentation
	set smartindent
	" If search contains capital letter search case sensitive otherwise case insensitve
	set showcmd
	set smartcase
	set hidden
	" Start scrolling up/down when 8 lines away from top/bottom line - keeps
	" cursor more centered
	"Create seperate centralized folders for temp and swp files
	set backupdir=.backup/,~/.backup/,/tmp//
	set directory=.swp/,~/.swp/,/tmp//
	set undodir=.undodir/,~/.undodir/,/tmp//
	set scrolloff=8
	set noshowmode
	set linebreak
	set ruler
	set cursorline
	set noerrorbells
	set visualbell
	set mouse=a
	set title
	set confirm
  set list
  set listchars=tab:‣\ ,trail:· "Display trailing whitespaces and leading tabs
  set clipboard+=unnamedplus "Use system clipboard
	
	" CONFIGURATION FOR COC.NVIM
	set nobackup " Some servers have issues with backup files
	set nowritebackup
	set timeoutlen=500
	set updatetime=100 " You will have a bad experience with diagnostic messages with the default 4000.
	set shortmess+=c " Don't give |ins-completion-menu| messages.
	set signcolumn=yes " Always show signcolumns
	au BufRead,BufNewFile *.sbt,*.sc set filetype=scala " Help Vim recognize *.sbt and *.sc as Scala files

	" Search down into subfolders
	" Provides tab-completion for all file-related tasks
	" just type :b or :find [filename] and use * 
	set path+=**
	" Display all matching files when we tab complete
	set wildmenu
	set wildmode=list:longest,full

	let mapleader=" "
	" Tweaks for file browsing
	" enable syntax highlighting and plugins (for netrw)
	syntax enable
	filetype plugin indent on
	let g:netrw_winsize=25
	let g:netrw_banner=1        " disable annoying banner
	let g:netrw_browse_split=2  " open file to the right of explorer
	let g:netrw_altv=1          " open splits to the right
	let g:netrw_liststyle=3     " tree view
	let g:netrw_hide = 0   
	let g:netrw_list_hide=netrw_gitignore#Hide()
	let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
	" - :edit [filename] a folder to open a file browser
	" - <CR>/v/t to open in an h-split/v-split/tab
	" - check |netrw-browse-maps| for more mappings 

	" TAG JUMPING:
	" install ctags with: sudo apt install universal-ctags
	" - Use ^] to jump to tag under cursor
	" - Use g^] for ambiguous tags
	" - Use ^t to jump back up the tag stack
	command! MakeTags !ctags -R .

	command! Reloadvimrc source ~/.vimrc

	" AUTOCOMPLETE:
	" The good stuff is documented in |ins-completion|
	" - ^x^n for JUST this file
	" - ^x^f for filenames (works with our path trick!)
	" - ^x^] for tags only
	" - ^n for anything specified by the 'complete' option
	" - Use ^n and ^p to go back and forth in the suggestion list

	" FILE BROWSING:
	if executable('rg')
		let g:rg_derive_root='true'
		let g:rg_highlight='true'
		set grepprg=rg\ --color=never
	endif

	" REMAPPINGS:
	" Allow saving of files as sudo when I forgot to start vim using sudo.
	cnoremap w!! w !sudo tee > /dev/null %
	" Remap Esc to jk
	inoremap jk <ESC>
	" Remap switching between windows
	nnoremap <leader>h :wincmd h<CR>
	nnoremap <leader>j :wincmd j<CR>
	nnoremap <leader>k :wincmd k<CR>
    nnoremap <leader>l :wincmd l<CR>
    " Open a new buffer with vertical split
    nnoremap <leader>n :vnew<CR>
    " fast quit
    nnoremap <leader>q :q<CR>
    " fast write
    nnoremap <leader>w :w<CR>
    " paste yanked word
    nnoremap <leader>p "0p
    nnoremap <silent> <Leader>+ :vertical resize +5<CR>
    nnoremap <silent> <Leader>- :vertical resize -5<CR>
    " fast lex commandleader
    "nnoremap <leader>e :Lex<CR> Currently replaced by coc-explorer
    " Move between tabs
    nnoremap <leader>1 :tabnext 1<CR>
    nnoremap <leader>2 :tabnext 2<CR>
    nnoremap <leader>3 :tabnext 3<CR>
    nnoremap <leader>4 :tabnext e<CR>
    nnoremap <leader>5 :tabnext 5<CR>
    nnoremap <leader>6 :tabnext 6<CR>
    nnoremap <leader>7 :tabnext 7<CR>
    nnoremap <leader>8 :tabnext 8<CR>
    nnoremap <leader>9 :tabnext 9<CR>
    " toggle search highlights 
    nnoremap <F3> :set hlsearch!<CR>
    " indent line/s
    vnoremap > >gv
    vnoremap < <gv
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv
    "Switch working directory to location of current file
    nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

    
    " FUNCTIONS:
    " Format innerword at current cursor location to first letter uppercase and
    " all following lower case e.g. 'Test'
      function! FormatInnerWord()
        normal guiw~e
      endfunction
      nnoremap <silent> <Leader>fiw :call FormatInnerWord()<CR>

    " TODO: Write a function that creates a variable amount of new lines
    
  " ---------------------------------------------------------------------------

  " ---------------------------------------------------------------------------
  " PLUGIN WINSHIFT CONFIG:
  " ---------------------------------------------------------------------------
    " let g:vimtex_view_method = 'zathura'

    " Or with a generic interface:
    let g:vimtex_view_general_viewer = 'okular'
    let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

    " Most VimTeX mappings rely on localleader and this can be changed with the
    " following line. The default is usually fine and is the symbol "\".
    let maplocalleader = ","
  " ---------------------------------------------------------------------------


  " ---------------------------------------------------------------------------
  " PLUGIN WINSHIFT CONFIG:
  " ---------------------------------------------------------------------------
    " Start Win-Move mode:
    nnoremap <C-W><C-M> <Cmd>WinShift<CR>
    nnoremap <C-W>m <Cmd>WinShift<CR>

    " Swap two windows:
    nnoremap <C-W>x <Cmd>WinShift swap<CR>

  " If you don't want to use Win-Move mode you can create mappings for calling the
  " move commands directly:
  nnoremap <C-M-H> <Cmd>WinShift left<CR>
  nnoremap <C-M-J> <Cmd>WinShift down<CR>
  nnoremap <C-M-K> <Cmd>WinShift up<CR>
  nnoremap <C-M-L> <Cmd>WinShift right<CR>
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN NVIM WINDOW CONFIG:
" ---------------------------------------------------------------------------
  map <silent> <leader><leader> :lua require('nvim-window').pick()<CR>
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN GIT GUTTER CONFIG:
" ---------------------------------------------------------------------------
  " Currently all ultisnips keybindings are set to §
  let g:UltiSnipsExpandTrigger="§"
  let g:UltiSnipsJumpForwardTrigger="§"
  let g:UltiSnipsJumpBackwardTrigger="§"
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN GIT GUTTER CONFIG:
" ---------------------------------------------------------------------------
  nnoremap <leader>ghs <Plug>(GitGutterStageHunk)
  nnoremap <leader>ghu <Plug>(GitGutterUndoHunk)
  nnoremap <leader>ghp <Plug>(GitGutterPreviewHunk)
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN VIM MOVE CONFIG:
" ---------------------------------------------------------------------------
	let g:move_key_modifier_visualmode='S'
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN VIM SNEAK CONFIG:
" ---------------------------------------------------------------------------
	let g:sneak#label = 1
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN UNDOTREE CONFIG:
" ---------------------------------------------------------------------------
	nnoremap <leader>u :UndotreeShow<CR>
	
	" Configuration for undotree plugin and persistent undo
	if has("persistent_undo")
		 let target_path = expand('~/.undodir')

			" create the directory and any parent directories
			" if the location does not exist.
			if !isdirectory(target_path)
					call mkdir(target_path, "p", 0700)
			endif

			let &undodir=target_path
			set undofile
	endif
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN VIM WHICH KEY CONFIG:
" ---------------------------------------------------------------------------
	" keymapping for vim-which-key plugin
	nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN GRUVBOX CONFIG:
" ---------------------------------------------------------------------------
	" If gruvbox plugin is install, sets gruvbox theme
	" let g:gruvbox_guisp_fallback = "bg"
	" colorscheme gruvbox
  set background=dark
  let g:tokyonight_style = "storm"
  colorscheme tokyonight
	" Make backgound transparent
  " hi Normal guibg=NONE ctermbg=NONE
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN FZF CONFIG:
" ---------------------------------------------------------------------------
	let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
	let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
  " Default command is used on fzf Files command
  " Include hidden files but exclude .git folder
	let $FZF_DEFAULT_COMMAND='ag --hidden --ignore=.git --ignore=.idea -g  ""' 
	" Or use ripgrep instead of ag for fzf fuzzy file search
	command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
	command! -bang -nargs=* GGrep
  "'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
		\ call fzf#vim#grep(
		\   'git grep --line-number -- '.shellescape(<q-args>), 0,
		\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
	command! -bang -nargs=* Rg
		\ call fzf#vim#grep(
		\   'rg --column --hidden --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
		\   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

	" Project search with ripgrep
	nnoremap <leader>s :Rg<CR>
	"nnoremap <silent> <C-p> :call fzf#run(fzf#wrap({'source': 'ag -g ""'}))<CR>
	nnoremap <silent> <C-p> <esc>:Files<CR>
	"Mapping for fzf-checkout Plugin for git commits
	nnoremap <leader>gc :GCheckout<CR>
	nnoremap <leader>gs :G<CR>
  nnoremap <leader>gb :GBranches<CR>
  nnoremap <leader>/ :BTags<cr>
	nnoremap <leader>B :Buffer<CR>
	nnoremap <leader>H :History<CR>
	inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
		\ fzf#wrap({'dir': expand('%:p:h')}))

	if has('nvim')
		"Exit fzf floating window and terminal with Esc
		au! TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
		au! FileType fzf tunmap <buffer> <Esc>
	endif
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN FLOATERM CONFIG:
" ---------------------------------------------------------------------------
  function! s:currentFloatermName()
    let bufNr = floaterm#buflist#curr()
    let currentFloatermName = floaterm#terminal#get_bufname(bufnr)
  endfunction
  let g:floaterm_keymap_new = ';t'
  let g:floaterm_opener = 'edit'
  tnoremap ;x <cmd>FloatermKill(s:currentFloatermName())<cr><cmd>FloatermShow()<cr>
  tnoremap ;n <cmd>FloatermNext<cr>
  tnoremap ;p <cmd>FloatermPrev<cr>
  tnoremap ;q <cmd>FloatermHide<cr>
  tnoremap ;<space> <cmd>FloatermToggle<cr>
  nnoremap <leader>; <cmd>FloatermToggle<cr>
" TODO: Also checkout LazyDocker
  " Use key mapping <A-]> to send the <esc> key to the terminal
	nnoremap <silent> <leader>gg :FloatermNew lazygit<cr>
  " This way Esc key can be send to underlying program in termeinal
  tnoremap <A-]> <Esc>
  " Close floaterm with <esc> in normal mode 
  au! FileType floaterm nnoremap <buffer> <Esc> <C-\><C-n>:q<cr>
  " Set floaterm window's background to transparent
  hi Floaterm guibg=NONE
  " Set floating window border line color and background to transparent
  hi FloatermBorder guibg=NONE guifg=NONE
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN CAMELCASEMOTION CONFIG:
" ---------------------------------------------------------------------------
	map <silent> w <Plug>CamelCaseMotion_w
	map <silent> b <Plug>CamelCaseMotion_b
	map <silent> e <Plug>CamelCaseMotion_e
	map <silent> ge <Plug>CamelCaseMotion_ge
	sunmap w
	sunmap b
	sunmap e
	sunmap ge
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN COC CONFIG:
" ---------------------------------------------------------------------------
  let g:coc_global_extensions = ['coc-highlight', 'coc-yank', 'coc-lists', 'coc-vimlsp', 'coc-json', 'coc-metals', 'coc-java', 'coc-html', 'coc-htmlhint', 'coc-cssmodules', 'coc-html-css-support', 'coc-tsserver', 'coc-python', 'coc-snippets', 'coc-angular', 'coc-css', 'coc-markdownlint', 'coc-webview', 'coc-markdown-preview-enhanced', 'coc-ltex', 'coc-sql', 'coc-xml', 'coc-yaml', 'coc-calc', 'coc-diagnostic', 'coc-eslint', 'coc-highlight', 'coc-sh', 'coc-pairs', 'coc-explorer', 'coc-flutter', 'coc-texlab', 'coc-vimtex', 'coc-lightbulb']


  " COC SNIPPETS CONFIG:
    " use <c-l> for trigger snippet expand.
    imap <c-l> <plug>(coc-snippets-expand)

    " use <c-j> for select text for visual placeholder of snippet.
    vmap <c-j> <plug>(coc-snippets-select)

    " use <c-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'

    " use <c-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'

    " use <c-j> for both expand and jump (make expand higher priority.)
    imap <c-j> <plug>(coc-snippets-expand-jump)

    " use <leader>x for convert visual selected code to snippet
    xmap <leader>x  <plug>(coc-convert-snippet)

    let g:coc_snippet_next = '<tab>'

    " Include something like this and also check if there is only one option
    " to immediately select and confirm 
    " inorwmap <silent><expr> <TAB>
    "       \ pumvisible() ? coc#_select_confirm() :

    if exists('*complete_info')
      inoremap <silent><expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    "
    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by another plugin.
    inoremap <silent><expr> <TAB>
    		 \ pumvisible() ? "\<C-n>" :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<c-h>"

    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-space> pumvisible() ? "\<c-e>" : coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif


  "COC-EXPLORER CONFIG
  nnoremap <leader>e <Cmd>CocCommand explorer<CR>

  " Use coc-explorer instead of netrw as default fileexplorer 
  function! s:DisableFileExplorer()
      au! FileExplorer
  endfunction

  function! s:OpenDirHere(dir)
      if isdirectory(a:dir)
        exec "silent CocCommand explorer " . a:dir
      endif
  endfunction

  " Taken from vim-easytree plugin, and changed to use coc-explorer
  augroup CocExplorerDefault
      autocmd!
      autocmd VimEnter * call <SID>DisableFileExplorer()
      autocmd BufEnter * if &ft != "coc-list" && &ft != "coc-explorer" | call <SID>OpenDirHere(expand('<amatch>'))
      autocmd VimEnter * cd %:p:h 
  augroup end

  function! s:ChangeDir()
    silent call CocAction('runCommand', 'explorer.doAction', 0, ['copyFilepath']) 
    if isdirectory(getreg('+'))
      execute 'cd '.getreg('+')
      echo 'change working directory to: '.getreg('+')
    endif
  endfunction

	augroup cocexplorer
    autocmd FileType coc-explorer map <silent><buffer> cd :call <SID>ChangeDir()<cr>
  augroup end

	nnoremap <Leader>calc <Plug>(coc-calc-result-append)
		\ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",

	" Use `[g` and `]g` to navigate diagnostics
	noremap <silent> [g <Plug>(coc-diagnostic-prev)
	nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

	" Remap keys for gotos
	noremap <silent> gd <Plug>(coc-definition)
	noremap <silent> gy <Plug>(coc-type-definition)
	noremap <silent> gi <Plug>(coc-implementation)
	noremap <silent> gr <Plug>(coc-references)

	" Used to expand decorations in worksheets Original mapping was ws
	noremap <Leader>dec <Plug>(coc-metals-expand-decoration) 

	" To move into the floating window press <c-w>p
	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		elseif (coc#rpc#ready())
			call CocActionAsync('doHover')
		else
			execute '!' . &keywordprg . " " . expand('<cword>')
		endif
	endfunction

	" Use K to either doHover or show documentation in preview window
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	" Seems not be working...
	if has('nvim-0.4.0') || has('patch-8.2.0750')
		nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
		nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
		inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
		inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
		vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
		vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	endif
	" Mappings for CoCList
	" Show all diagnostics.
	nnoremap <silent><nowait> <leader>cdi  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
	nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
	" Show commands.
	nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent><nowait> <leader>cj  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent><nowait> <leader>ck  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <silent><nowait> <leader>cp  :<C-u>CocListResume<CR>

	" Toggle panel with Tree Views
	nnoremap <silent> <leader>mt :<C-u>CocCommand metals.tvp<CR>
	" Toggle Tree View 'metalsPackages'
	nnoremap <silent> <leader>mtp :<C-u>CocCommand metals.tvp metalsPackages<CR>
	" Toggle Tree View 'metalsCompile'
	nnoremap <silent> <leader>mtc :<C-u>CocCommand metals.tvp metalsCompile<CR>
	" Toggle Tree View 'metalsBuild'
	nnoremap <silent> <leader>mtb :<C-u>CocCommand metals.tvp metalsBuild<CR>
	" Reveal current current class (trait or object) in Tree View 'metalsPackages'
	nnoremap <silent> <leader>mtf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>

	" Remap for rename current word
	noremap <leader>rn <Plug>(coc-rename)
	"
	" Remap for format selected region
	xmap <leader>f  <Plug>(coc-format-selected)
	noremap <leader>f  <Plug>(coc-format-selected)

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	noremap <leader>a  <Plug>(coc-codeaction-selected)
	" Remap keys for applying codeAction to the current buffer.
	noremap <leader>ac  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	noremap <leader>af  <Plug>(coc-fix-current)
	" Trigger for code actions
	" Make sure `"codeLens.enable": true` is set in your coc config
	nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>

	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType scala setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " In order to get comment highlighting in json
    autocmd FileType json syntax match Comment +\/\/.\+$+
	augroup end

	" Use `:Format` to format current buffer
	command! -nargs=0 Format :call CocAction('format')

	" Use `:Fold` to fold current buffer
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" ---------------------------------------------------------------------------


" ---------------------------------------------------------------------------
" PLUGIN STARTIFY CONFIG:
" ---------------------------------------------------------------------------
" USAGE: Commands start with :S like :SSave to save a session. To start
" Startify use :Startify
  let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   Files']            },
            \ { 'type': 'dir',       'header': ['   Current Dir '. getcwd()] },
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'commands',  'header': ['   Commands']       },
            \ ]
  "TODO: Create commands to setup different kinds of projects
  let g:startify_commands = [
            \ ['Vim Reference', 'h ref'],
            \ ]
  " \ {'m': ['My magical function', 'call Magic()']},
  let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ 'bundle/.*/doc',
            \ '/data/repo/neovim/runtime/doc',
            \ '/Users/mhi/local/vim/share/vim/vim74/doc',
            \ ]
  let g:startify_bookmarks = [ {'c': '~/.vimrc'}, {'aa': '~/AndroidStudioProjects/anovi-app'}, {'aw': '~/Schreibtisch/anovi_website'}, {'n': '~/OneDrive/notes'}, {'gi': '~/.gitconfig'}, {'co': '~/config/nvim/coc-settings.json'}, {'bf': '~/.bash_functions'}, {'ba': '~/.bash_aliases'}, {'br': '~/.bashrc'}]
  let g:startify_update_oldfiles = 1
  let g:startify_files_number = 10
  let g:startify_change_cmd = 'cd'
  let g:startify_session_persistence = 1
  let g:startify_session_autoload = 1
  let g:startify_session_delete_buffers = 1
  let g:startify_change_to_vcs_root = 1
  let g:startify_fortune_use_unicode = 1
  let g:startify_enable_special = 0
  let g:startify_session_dir = '~/.config/nvim/session'
  function! s:get_random_offset(max) abort
    return str2nr(matchstr(reltimestr(reltime()), '\.\zs\d\+')[1:]) % a:max
  endfunction
  function! Update_asci_art()
    let g:startify_custom_header = map(startify#fortune#boxed() + g:asci_art[<SID>get_random_offset(len(g:asci_art))], '"   ".v:val')
  endfunction
  " Define the size of the floating window
  function! OpenFloatingWindow()
    let width = 80
    let height = 50 

    " Create the scratch buffer displayed in the floating window
    let buf = nvim_create_buf(v:false, v:true)

    " Get the current UI
    let ui = nvim_list_uis()[0]

    " Create the floating window
    let opts = {'relative': 'editor',
                \ 'width': width,
                \ 'height': height,
                \ 'col': (ui.width/2) - (width/2),
                \ 'row': (ui.height/2) - (height/2),
                \ 'anchor': 'NW',
                \ 'border': 'single',
                \ 'style': 'minimal',
                \ }
    let win = nvim_open_win(buf, 1, opts)
  endfunction
  function! ToggleStartify()
    if &ft != 'Startify'
      call Update_asci_art()
      call OpenFloatingWindow()
      execute "Startify"
    else
      execute "q"
    endif
  endfunction
  if has('nvim')
    function! SwitchWindowAfterStartifyOpen()
      let currentBuffer = nvim_get_current_buf()
      let currentWindow = nvim_get_current_win()
      "TODO check if window is a floating window
      if !empty(nvim_win_get_config(currentWindow).relative)
        call nvim_win_close(currentWindow, 0)
        let previousWindow = nvim_get_current_win()
        call nvim_win_set_buf(previousWindow, currentBuffer)
      endif
    endfunction
    autocmd User StartifyBufferOpened call SwitchWindowAfterStartifyOpen()
  endif
  "   
  " Wenn floating window -> aktuelles floating window schließen ansonsten
  " nichts tun
  " neues Window in vsplit öffnen
  "
  nnoremap <leader><tab> :call ToggleStartify()<cr>
  autocmd User Startified setlocal cursorline

  let g:asci_art = [[
        \"⠀⠀⣀⣀⣤⣤⣦⣶⢶⣶⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⡄⠀⠀⠀⠀⠀",
        \"⠀⠀⣿⣿⣿⠿⣿⣿⣾⣿⣿⣿⣿⣿⣿⠟⠛⠛⢿⣿⡇⠀⠀⠀⠀⠀",
        \"⠀⠀⣿⡟⠡⠂⠀⢹⣿⣿⣿⣿⣿⣿⡇⠘⠁⠀⠀⣿⡇⠀⢠⣄⠀⠀",
        \"⠀⠀⢸⣗⢴⣶⣷⣷⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣴⣿⣗⣄⣼⣷⣶⡄",
        \"⠀⢀⣾⣿⡅⠐⣶⣦⣶⠀⢰⣶⣴⣦⣦⣶⠴⠀⢠⣿⣿⣿⣿⣼⣿⡇",
        \"⢀⣾⣿⣿⣷⣬⡛⠷⣿⣿⣿⣿⣿⣿⣿⠿⠿⣠⣿⣿⣿⣿⣿⠿⠛⠃",
        \"⢸⣿⣿⣿⣿⣿⣿⣿⣶⣦⣭⣭⣥⣭⣵⣶⣿⣿⣿⣿⣟⠉⠀⠀⠀⠀",
        \"⠀⠙⠇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⣿⣿⣿⣿⣿⣛⠛⠛⠛⠛⠛⢛⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠿⣿⣿⣿⠿⠿⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⠿⠇⠀⠀⠀⠀⠀"],
        \[
        \"⠀⠀⠀⠀⠀⠀⠀⠀⡠⠔⠉⠀⠀⠀⠀⠀⠉⠒⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⢀⣞⣀⣀⡀⠀⢀⣀⣀⣀⡀⠀⠀⠱⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⡌⢾⣿⡇⠀⠀⠰⣿⣷⠀⠀⠀⠀⢀⢱⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⡇⠀⠉⠀⠀⠀⣠⣬⣵⣤⣄⠀⠀⠀⠙⡄⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⢣⠀⠀⠀⠴⢿⣿⣿⣿⣿⠟⡣⡀⠀⣠⠃⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠳⡀⠀⠀⠀⠈⠉⠉⠉⠁⠂⢁⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠠⢦⣤⣀⡀⠀⠈⠒⠤⣀⣀⡀⣀⣀⠤⠐⠳⣦⣤⣤⣤⠶⠶⠶⢦⣤⡀⠀",
        \"⠀⠀⠀⠀⠈⠉⠙⠛⠻⠶⠶⠶⠶⠶⠶⠶⠶⠾⡟⠋⠻⣶⡒⠒⠦⠤⡤⡈⢻⡆",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⢀⠀⠘⣷⠀⠀⠀⡇⡇⣸⠇",
        \"⠀⠀⠀⣀⣀⣀⣀⣠⣤⣤⣤⣤⣤⣖⣺⢻⣝⣋⣽⣳⣶⣶⣿⣦⡴⣼⢷⡟⠋⠀",
        \"⠛⠛⠛⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠳⣌⠉⠉⠉⣡⠞⠉⠉⠛⠳⢶⣼⢸⠂⠀⠀",
        \" ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠙⣿⡀⠀⠀"],
        \[
        \"⠀⠀⠀⠀⠀⠀⣠⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
        \"⠀⠀⠀⠀⢀⣀⣕⡋⠘⠐⠂⡑⠃⠉⢲⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
        \"⠀⠀⠀⠀⠀⢻⠃⢀⡤⠰⡎⠈⣉⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
        \"⠀⠀⠀⡀⢀⡎⠀⠠⣀⠀⠈⠉⠁⠠⢄⠈⡗⠲⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
        \"⠀⢥⣦⠶⣗⢩⣰⢈⢁⠀⣀⠀⠀⢀⠨⢠⠇⠀⢹⢳⡉⣓⣶⣄⠀⠀⠀⠀⠀⠀ ",
        \"⠀⠀⠀⢀⠀⠉⠙⠢⠥⣄⣀⣀⣀⣤⠴⠋⠀⠀⢸⡎⣿⡀⠀⢹⣏⠉⠉⠒⢦⠀ ",
        \"⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠀⢸⣇⣴⠈⣿⡄⠀⢀⠻⠀ ",
        \"⣠⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠴⣶⣭⣽⣻⣻⣯⣽⣿⣿⣀⣻⡇⠀⠀⡅⠀ ",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠚⠋⠳⣀⣀⣀⣀⣀⣠⠞⠃⠀⠀⠉⠉⠉⠙⠓ "],
        \[
        \"⠄⠄⠄⠄⠄⠄⢀⣠⣤⣶⣶⣶⣤⣄⠄⠄⢀⣠⣤⣤⣤⣤⣀⠄⠄⠄⠄⠄⠄⠄",
        \"⠄⠄⠄⠄⢠⣾⣿⣿⣿⣿⠿⠿⢿⣿⣿⡆⣿⣿⣿⣿⣿⣿⣿⣷⡄⠄⠄⠄⠄⠄",
        \"⠄⠄⠄⣴⣿⣿⡟⣩⣵⣶⣾⣿⣷⣶⣮⣅⢛⣫⣭⣭⣭⣭⣭⣭⣛⣂⠄⠄⠄⠄",
        \"⠄⠄⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣭⠛⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠄",
        \"⣠⡄⣿⣿⣿⣿⣿⣿⣿⠿⢟⣛⣫⣭⠉⠍⠉⣛⠿⡘⣿⠿⢟⣛⡛⠉⠙⠻⢿⡄",
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣭⣍⠄⣡⣬⣭⣭⣅⣈⣀⣉⣁⠄",
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣛⡻⠿⠿⢿⣿⡿⢛⣥⣾⣿⣿⣿⣿⣿⣿⣿⠿⠋⠄",
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣩⣵⣾⣿⣿⣯⣙⠟⣋⣉⣩⣍⡁⠄⠄⠄",
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣷⡄⠄⠄",
        \"⣿⣿⣿⣿⣿⣿⡿⢟⣛⣛⣛⣛⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⡀⠄",
        \"⣿⣿⣿⣿⣿⡟⢼⣿⣯⣭⣛⣛⣛⡻⠷⠶⢶⣬⣭⣭⣭⡭⠭⢉⡄⠶⠾⠟⠁⠄",
        \"⣿⣿⣿⣿⣟⠻⣦⣤⣭⣭⣭⣭⣛⣛⡻⠿⠷⠶⢶⣶⠞⣼⡟⡸⣸⡸⠿⠄⠄⠄",
        \"⣛⠿⢿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠷⡆⣾⠟⡴⣱⢏⡜⠆⠄⠄⠄",
        \"⣭⣙⡒⠦⠭⣭⣛⣛⣛⡻⠿⠿⠟⣛⣛⣛⣛⡋⣶⡜⣟⣸⣠⡿⣸⠇⣧⡀⠄⠄",
        \"⣿⣿⣿⣿⣷⣶⣦⣭⣭⣭⣭⣭⣭⣥⣶⣶⣶⡆⣿⣾⣿⣿⣿⣷⣿⣸⠉⣷⠄⠄"],
        \[
        \"⣿⣿⣿⣿⣿⣿⣿⠟⠋⠉⠁⠈⠉⠙⠻⢿⡿⠿⠛⠋⠉⠙⠛⢿⣿⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣿⠟⠁⠀⠀⢀⣀⣀⣀⣀⡀⠀⢆⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⠃⠀⠀⠠⠊⠁⠀⠀⠀⠀⠈⠑⠪⡖⠒⠒⠒⠒⠒⠒⠶⠛⠿⣿⣿⣿",
        \"⣿⣿⡿⡇⠀⠀⠀⠀⠀⠀⡠⢔⡢⠍⠉⠉⠩⠭⢑⣤⣔⠲⠤⠭⠭⠤⠴⢊⡻⣿",
        \"⡿⠁⢀⠇⠀⠀⠀⣤⠭⠓⠊⣁⣤⠂⠠⢀⡈⠱⣶⣆⣠⣴⡖⠁⠂⣀⠈⢷⣮⣹",
        \"⠁⠀⠀⠀⠀⠀⠀⠈⠉⢳⣿⣿⣿⡀⠀⠀⢀⣀⣿⡿⢿⣿⣇⣀⣥⣤⠤⢼⣿⣿",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡟⠑⠚⢹⡟⠉⣑⠒⢺⡇⡀⠀⡹⠀⠀⣀⣴⣽⣿⣿",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⣿⠒⠉⠀⠀⢠⠃⠈⠙⠻⣍⠙⢻⡻⣿⣿⣿",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⣀⣘⡄⠀⠀⢸⡇⠀⠀⠀⠘⡇⠀⠀⠀⠘⡄⠀⢱⢸⣿⣿",
        \"⠀⠀⠀⠀⠠⡀⠀⠾⣟⣻⣛⠷⣶⣼⣥⣀⣀⣀⠀⢧⠀⠀⠀⠠⣧⣀⣼⣴⢽⣿",
        \"⠀⠀⠀⠀⠀⠈⠉⠁⠀⠹⡙⠛⠷⣿⣭⣯⣭⣟⣛⣿⣿⣿⣛⣛⣿⣭⣭⣾⣿⣿",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⠀⠀⣇⠀⠉⠉⠉⡏⠉⠙⠛⠛⡿⣻⣯⣷⣿⣿⣿",
        \"⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⢸⠀⠀⠀⡸⠁⣠⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣶⣶⣦⣤⣤⣤⣷⣤⣄⣈⣆⣤⣤⣧⣶⣷⣿⡻⣿⣿⣿⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⢿⣿⣿⣿⣿⣿⣿"],
        \[
        \"⣿⣿⣿⣿⣿⣿⠿⢋⣥⣴⣶⣶⣶⣬⣙⠻⠟⣋⣭⣭⣭⣭⡙⠻⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⡿⢋⣴⣿⣿⠿⢟⣛⣛⣛⠿⢷⡹⣿⣿⣿⣿⣿⣿⣆⠹⣿⣿⣿⣿",
        \"⣿⣿⣿⡿⢁⣾⣿⣿⣴⣿⣿⣿⣿⠿⠿⠷⠥⠱⣶⣶⣶⣶⡶⠮⠤⣌⡙⢿⣿",
        \"⣿⡿⢛⡁⣾⣿⣿⣿⡿⢟⡫⢕⣪⡭⠥⢭⣭⣉⡂⣉⡒⣤⡭⡉⠩⣥⣰⠂⠹",
        \"⡟⢠⣿⣱⣿⣿⣿⣏⣛⢲⣾⣿⠃⠄⠐⠈⣿⣿⣿⣿⣿⣿⠄⠁⠃⢸⣿⣿⡧",
        \"⢠⣿⣿⣿⣿⣿⣿⣿⣿⣇⣊⠙⠳⠤⠤⠾⣟⠛⠍⣹⣛⣛⣢⣀⣠⣛⡯⢉⣰",
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡶⠶⢒⣠⣼⣿⣿⣛⠻⠛⢛⣛⠉⣴⣿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⡿⢛⡛⢿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡈⢿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⠸⣿⡻⢷⣍⣛⠻⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢇⡘⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⣷⣝⠻⠶⣬⣍⣛⣛⠓⠶⠶⠶⠤⠬⠭⠤⠶⠶⠞⠛⣡⣿",
        \"⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣬⣭⣍⣙⣛⣛⣛⠛⠛⠛⠿⠿⠿⠛⣠⣿⣿",
        \"⣦⣈⠉⢛⠻⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⣁⣴⣾⣿⣿⣿⣿",
        \"⣿⣿⣿⣶⣮⣭⣁⣒⣒⣒⠂⠠⠬⠭⠭⠭⢀⣀⣠⣄⡘⠿⣿⣿⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡈⢿⣿⣿⣿⣿⣿"],
        \[
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣉⡥⠶⢶⣿⣿⣿⣿⣷⣆⠉⠛⠿⣿⣿⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⡿⢡⡞⠁⠀⠀⠤⠈⠿⠿⠿⠿⣿⠀⢻⣦⡈⠻⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⡇⠘⡁⠀⢀⣀⣀⣀⣈⣁⣐⡒⠢⢤⡈⠛⢿⡄⠻⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⡇⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠉⠐⠄⡈⢀⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⠇⢠⣿⣿⣿⣿⡿⢿⣿⣿⣿⠁⢈⣿⡄⠀⢀⣀⠸⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⡿⠟⣡⣶⣶⣬⣭⣥⣴⠀⣾⣿⣿⣿⣶⣾⣿⣧⠀⣼⣿⣷⣌⡻⢿⣿",
        \"⣿⣿⠟⣋⣴⣾⣿⣿⣿⣿⣿⣿⣿⡇⢿⣿⣿⣿⣿⣿⣿⡿⢸⣿⣿⣿⣿⣷⠄⢻",
        \"⡏⠰⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⢂⣭⣿⣿⣿⣿⣿⠇⠘⠛⠛⢉⣉⣠⣴⣾",
        \"⣿⣷⣦⣬⣍⣉⣉⣛⣛⣉⠉⣤⣶⣾⣿⣿⣿⣿⣿⣿⡿⢰⣿⣿⣿⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡘⣿⣿⣿⣿⣿⣿⣿⣿⡇⣼⣿⣿⣿⣿⣿⣿⣿⣿",
        \"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⣿⣿⣿⣿⣿⣿⣿⠁⣿⣿⣿⣿⣿⣿⣿⣿⣿"],
        \[
        \" ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠈⠿⠟⠉⠀⠀⠀⢀⣿⠇⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⣿⡿⠿⠿⠿⠷⣶⣾⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣤⣤⣴⣶⣶⡀",
        \"⠀⠀⠀⠹⣿⡀⠀⠀⠀⠀⠀⠀⢀⡤⠖⠚⠉⠉⠉⠉⠛⠲⣄⠀⠈⠉⠉⠉⠁⣼⡟⠀",
        \"⠀⠀⠀⠀⠹⣷⡀⠀⠀⠀⢀⡔⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⡄⠀⠀⢀⣼⡟⠀⠀",
        \"⠀⠀⠀⠀⠀⢹⣷⠀⠀⢀⡎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡀⢠⣾⡏⠀⠀⠀",
        \"⠀⢀⣠⣴⡾⠟⠋⠀⠀⣸⠀⠀⠀⣴⣒⣒⣛⣛⣛⣋⣉⣉⣉⣙⣛⣷⠀⠙⠿⣶⣤⡀",
        \"⣾⣿⡋⠁⠀⠀⠀⠀⠀⡏⠀⠀⡄⠉⠉⠁⠀⠈⢹⢨⠃⠀⠀⠀⠀⠙⡄⠀⠀⣨⣿⠟",
        \"⠈⠛⠿⣷⣦⣀⠀⠀⠀⡇⠀⠸⡟⠛⠿⠛⠛⠛⢻⢿⠋⠹⠟⠉⠉⠙⡇⣠⣾⠟⠁⠀",
        \"⠀⠀⠀⢀⣽⣿⠇⠀⠀⡇⠀⠀⠳⣄⣀⠀⣀⣠⠞⠈⢷⣄⣀⣀⣠⣾⠁⢿⣧⡀⠀⠀",
        \"⠀⢠⣴⡿⠋⠁⠀⠀⢀⡧⠄⠀⠦⣀⣈⣉⠁⠀⠠⡀⠘⡆⠠⠤⠴⢿⣄⠀⠙⣿⣦⠀",
        \"⠀⠹⢿⣦⣤⣀⠀⢰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⣤⠇⠀⠀⠀⣼⢘⣷⡿⠟⠋⠀",
        \"⠀⠀⠀⠈⠉⣿⡇⠈⠣⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠻⣿⡀⠀⠀⠀",
        \"⠀⠀⠀⠀⢸⣿⣤⣤⣤⣤⢧⠀⢀⡆⣠⠴⠒⠋⢹⠋⠉⢹⠗⠒⠄⣷⣾⡿⠇⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠉⠉⠉⣿⣇⣈⣆⠀⠳⠤⠀⠀⠀⠈⣇⡖⡍⠀⠠⣾⣿⡿⠇⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠛⢻⣷⣄⠀⠀⠀⠀⠁⠉⠀⠀⣠⣾⠟⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣉⣿⣷⠲⠤⠤⠤⣤⣶⣿⣟⠁⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⢀⣴⣶⡿⠿⠛⠛⢋⢹⡦⣄⣀⡤⢿⢉⠛⠛⠿⣷⣦⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⣿⠏⠀⠀⠀⠀⢀⠇⠈⡇⠀⠀⠀⠘⡎⣆⠀⠀⠀⢻⣧⠀⠀⠀⠀⠀"],
        \[
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣀⠀⢀⣼⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣷⣾⣿⣿⣷⣤⣤⣶⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣘⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣍⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠉⢽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠋⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣸⣀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⡛⣃⣤⣄⠀⠀⠀⠀⠀⣀⣀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠻⣿⣿⣿⣆⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⢠⣿⣿⣟⠛⠛⡏⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠉⣿⣿⣆⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣼⣿⡟⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠘⣿⣿⡆⢰⣿⡏⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠘⣿⣿⣿⣿⠃⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠘⣿⣿⡏⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠘⠟⠁⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣇⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠓⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠚⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⣠⣶⢶⣦⠀⣶⡶⠶⠆⣠⣶⣶⣶⣦⠀⠀⠀⣠⡶⢶⣦⠀⢀⣴⡶⣶⣦⢀⣶⠀⠰⣦⠀⣶⡄⠀⣶⠀⢰⡆⢰⣆⠀⣴⣶⠶⡆⣶⣶⣶⣶⣆⣶⡆⠀⢀⣦",
        \"⣸⡟⠀⠀⠀⠀⣿⣦⣤⠀⠉⠀⣿⡆⠀⠀⠀⠀⢿⣷⣤⡀⠀⣾⡏⠀⠀⠁⢸⣿⣤⣴⣿⡆⣿⡇⢠⣿⠀⣸⡇⢸⣿⠀⣿⣥⣤⠀⠈⢹⣿⠀⠀⠸⣿⣄⣼⠇",
        \"⢻⣧⡀⢸⣿⢀⣿⠉⠀⠀⠀⠀⣿⡇⠀⠀⠀⠠⣦⡈⠙⣿⡆⢿⣧⡀⢀⣠⢸⣿⠉⠀⣿⡇⢹⣧⣼⢿⣦⡿⠀⢸⣿⠀⣿⡏⠉⠀⠀⢸⣿⠀⠀⠀⢹⣿⠏⠀",
        \"⠈⠻⠿⠿⠋⠸⠟⠛⠛⠓⠀⠀⠿⠃⠀⠀⠀⠀⠙⠿⠿⠟⠁⠈⠻⠿⠿⠃⠘⠟⠀⠀⠛⠁⠀⠻⠃⠈⠛⠁⠀⠘⠟⠀⠻⠇⠀⠀⠀⠸⠿⠀⠀⠀⠺⠿⠀⠀"],
        \[
        \"    ,'``.._   ,'``.                             ",
        \"     :,--._:)\\,:,._,.:       All Glory to      ",
        \"     :`--,''   :`...';\\      the HYPNO TOAD!   ",
        \"      `,'       `---'  `.                       ",
        \"      /                 :                       ",
        \"     /                   \\                     ",
        \"   ,'                     :\\.___,-.            ",
        \"  `...,---'``````-..._    |:       \\           ",
        \"    (                 )   ;:    )   \\  _,-.    ",
        \"     `.              (   //          `'    \\   ",
        \"      :               `.//  )      )     , ;    ",
        \"    ,-|`.            _,'/       )    ) ,' ,'    ",
        \"   (  :`.`-..____..=:.-':     .     _,' ,'      ",
        \"    `,'\\ ``--....-)='    `._,  \\  ,') _ '``._ ",
        \" _.-/ _ `.       (_)      /     )' ; / \\ \\`-.'",
        \"`--(   `-:`.     `' ___..'  _,-'   |/   `.)     ",
        \"    `-. `.`.``-----``--,  .'                    ",
        \"      |/`.\\`'        ,','); SSt                ",
        \"          `         (/  (/                      "],
        \[
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⢣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠎⡴⢦⠱⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢎⣜⣉⣉⣧⡱⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢃⡞⠒⣒⣒⠒⢳⡘⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⣰⢡⣎⡩⠭⠤⠤⠭⢍⣱⡜⣆⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⡴⢡⡯⠴⢒⣈⣩⣉⣑⡒⠠⣹⡌⢦⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⡔⣡⣣⠔⡺⡋⡁⢀⡀⢈⠙⢟⠢⣝⣄⢢⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⢀⡜⣰⡟⠁⢰⡓⢎⣀⣸⣿⣷⡱⢚⡆⠈⢻⣆⢣⡀⠀⠀⠀⠀",
        \"⠀⠀⠀⢀⠎⡼⣇⠣⡀⠸⡄⢊⢿⣿⣿⡿⡑⢠⠇⢀⠜⣸⢧⠱⡀⠀⠀⠀",
        \"⠀⠀⢠⢋⢼⡙⢌⠳⣍⠲⢽⣄⣁⠂⠐⣈⣠⡯⠔⣡⠞⡡⢊⣧⡙⡄⠀⠀",
        \"⠀⣠⢃⣞⠣⡙⠦⡑⠦⣍⡒⠤⠬⠭⠭⠥⠤⢒⣩⠴⢊⠴⢋⠜⣳⡘⣄⠀",
        \"⣰⣃⣛⣚⣓⣚⣓⣚⣓⣒⣛⣛⣓⣒⣒⣚⣛⣛⣒⣚⣓⣚⣓⣚⣒⣛⣘⣆"],
        \[
        \"⠀⠀⠀⠀⠀⣴⠉⡙⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠤⣚⡯⠴⢬⣱⡀⠀",
        \"⠀⠀⠀⠀⢰⡇⣷⡌⢲⣄⡑⢢⡀⠀⠀⠀⠀⠀⢠⠾⢋⠔⣨⣴⣿⣷⡌⠇⡇ ",
        \"⠀⠀⠀⠀⢸⢹⣿⣿⣄⢻⣿⣷⣝⠷⢤⣤⣤⡶⢋⣴⣑⠟⠿⠿⠿⣿⣿⡀⡇⠀",
        \"⠀⠀⠀⠀⢸⢸⣿⡄⢁⣸⣿⣋⣥⣶⣶⣶⣶⣶⣶⣿⣿⣶⣟⡁⠚⣿⣿⡇⡇⠀",
        \"⢀⣠⡤⠤⠾⡘⠋⢀⣘⠋⠉⠉⠉⠉⢭⣭⣭⣭⣍⠉⢩⣭⠉⠉⠂⠙⠛⠃⣇⡀",
        \"⠏⠀⠀⢿⣿⣷⡀⠀⢿⡄⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣆⠀⢿⣇⠀⠀⠀⠀⠀⠀",
        \"⣦⠀⠀⠈⢿⣿⣧⠀⠘⣿⠀⠀⠀⡀⠀⠀⠘⣿⣿⣿⣿⡆⠀⢻⡆⠀⠀⠀⠀⠀",
        \"⢻⡄⠀⠀⠘⠛⠉⠂⠀⠙⠁⠀⣼⣧⠀⠀⠀⠈⠀⠀⠈⠙⠀⠘⠓⠀⠀⠀⠀⠀",
        \"⠀⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠛⢶⢰⣶⢢⣤⣤⣄⠲⣶⠖⠀⣙⣀⠀⠀⠀⠤⢤⣀⣀⡀⣀⣠⣾⠟⡌⠀",
        \"⠀⠀⠀⠘⢄⠃⣿⣿⣿⣿⠗⠀⠾⢿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣶⠸⠟⣡⣤⡳⢦",
        \"⠀⠀⠀⠀⠀⢻⡆⣙⡿⢷⣾⣿⣶⣾⣿⣿⣿⣿⣿⣿⣿⡿⠟⢡⣴⣾⣿⣿⣿⣦",
        \"⠀⠀⠀⠀⠀⡼⢁⡟⣫⣶⣍⡙⠛⠛⠛⠛⠛⣽⡖⣉⣠⣶⣶⣌⠛⢿⣿⣿⣿⣿",
        \"⠀⠀⠀⢀⠔⢡⢎⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠹⣿⣿⣿",
        \"⠀⢠⠖⢁⣴⡿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢹⣿⣿"],
        \[
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡤⠶⠶⠶⠶⠤⢤⣀⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⠤⠶⠶⠦⠤⣄⡈⠙⠲⣄⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠉⠳⣄⠈⢳⡀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠁⠀⠉⠑⠦⡀⠀⠀⠀⠀⠀⠀⠈⢳⡀⠹⡄",
        \"⠀⠀⠀⠀⠀⠀⢀⡏⠀⠀⣠⡀⠀⠀⠀⠘⡆⠀⠀⠀⠀⠀⠀⠀⢳⣀⡇",
        \"⠀⠀⠀⠀⠀⠀⢸⡀⠀⠀⠈⠀⠀⠀⠀⠀⣷⠖⠋⠉⠑⠒⠦⣄⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⢠⢧⡀⠀⠀⠀⠀⠀⢀⡼⠁⠀⠀⠀⠀⠀⠀⠈⢧⠀⠀",
        \"⠀⠀⣀⡤⠤⢤⣘⢦⡙⠢⠤⢤⡤⠴⠋⡇⠀⠀⠀⠐⠶⠀⠀⠀⢸⠀⠀",
        \"⠀⡼⢁⣴⣶⣶⣌⠑⠉⠑⢠⠞⠀⠀⠀⢳⡀⠀⠀⠀⠀⠀⠀⢀⡼⠀⠀",
        \"⢸⠁⣿⣿⣿⣿⣷⠷⣄⠀⣏⣀⡴⠊⠀⠀⠙⠦⢄⣀⣀⣀⡤⠚⠁⠀⠀",
        \"⠸⡄⣿⣿⣿⣿⣿⣿⡏⢳⣄⣀⠀⠀⠀⠀⠑⢦⣀⣀⣀⡄⠀⠀⠀⠀⠀",
        \"⠀⢳⡸⡿⣿⣿⣿⣿⣿⣿⣤⣿⣩⣿⣩⣷⣶⣤⡀⠀⡄⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠱⣝⢿⢻⣿⣿⣿⣿⣿⣿⠻⠿⢿⣿⣿⣿⣿⣦⠹⡄⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠈⠓⠙⢦⣿⠛⣿⣿⣿⣷⣦⠀⠙⣿⣿⣿⣿⡇⡇⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠈⠑⠯⣼⡿⠛⡿⣇⠀⢹⣿⣿⡿⣰⠃⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠓⢛⣒⢛⣋⡩⠞⠁⠀⠀⠀⠀⠀⠀",
        \"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀ "]]
  let a = Update_asci_art()
" ---------------------------------------------------------------------------




" ---------------------------------------------------------------------------
" CURRENTLY UNUSED CONFIG:
" ---------------------------------------------------------------------------
"
" ---------------------------------------------------------------------------
" PLUGIN YOUCOMPLETEME SETTINGS:
" ---------------------------------------------------------------------------
"	let g:ycm_auto_hover='CursorHold'
"	
"	 YCM Mappings Go to definition of current token
"	nnoremap <silent> <Leader>gg :YcmCompleter GoTo<CR>
"	nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>
"	nnoremap <silent> <Leader>gd :YcmCompleter GetDoc<CR>
"	nnoremap <silent> <Leader>gt :YcmCompleter GetType<CR>
"	nnoremap <silent> <Leader>gl :YcmCompleter Format<CR>
"	nnoremap <silent> <Leader>gi :YcmCompleter OrganizeImports<CR>
"	nnoremap <Leader>gr :YcmCompleter RefactorRename<SPACE>
" ---------------------------------------------------------------------------
"
"
" ---------------------------------------------------------------------------
"	" Move a line/block up or down
"	vnoremap J :m '>+1<CR>gv=gv
"	vnoremap K :m '<-2<CR>gv=gv
"
"	if executable('rg')
 	 "let g:ctrlp_user_command=['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'] 
 	 "let g:ctrlp_user_command=['rg %s --files --color=never --glob""'] 
"	endif
"	
"	let g:ctrlp_user_command=['fdfind --type f -c never "" "%s"'] 
"	let g:ctrlp_use_caching=0
"	let g:ctrlp_working_path_mode='ra'
"	let g:ctrlp_switch_buffer='et'
"	let g:ctrlp_show_hidden = 1
"	let g:ctrlp_root_markers=['pom.xml']
"	let g:ctrlp_custom_ignore = {
"	  \ 'dir':  '\v[\/]\.(doc|tmp|node_modules|git|hg|svn)$',
"	  \ 'file': '\v\.(exe|so|dll|class|swp)$',
"	  \ 'link': 'some_bad_symbolic_links',
"	  \ }
" ---------------------------------------------------------------------------
"
"
" ---------------------------------------------------------------------------
" CUSTOM TERMINAL:
" ---------------------------------------------------------------------------
" if has('nvim')
" 	nnoremap <silent> <Leader>ter :botright split<CR>:terminal<CR>gi
" else
" 	nnoremap <silent> <Leader>ter :botright terminal<CR>gi
" endif
"
" Toggle 'default' terminal
" nnoremap <silent> <C-z> :call ChooseTerm("term-slider", 1)<CR>
" Start terminal in current pane
" tnoremap <silent> <C-z> <C-\><C-n> :call ChooseTerm("term-pane", 0)<CR>
" nnoremap <silent> <C-x> :call ChooseTerm("term-pane", 0)<CR>
" append result on current expression
"
" function! ChooseTerm(termname, slider)
"     let pane = bufwinnr(a:termname)
"     let buf = bufexists(a:termname)
"     if pane > 0
"         " pane is visible
"         if a:slider > 0
"             :exe pane . "wincmd c"
"         else
"             :exe "e #" 
"         endif
"     elseif buf > 0
"         " buffer is not in pane
"         if a:slider
"             :exe "botright split"
"         endif
"         :exe "buffer " . a:termname
" 		startinsert
"     else
"         " buffer is not loaded, create
"         if a:slider
"             :exe "botright split"
"         endif
"         :terminal
"         :exe "f " a:termname
" 		startinsert
"     endif
" endfunction
" ---------------------------------------------------------------------------

