" Reload vimrc commands: ":so $MYVIMRC" or ":source ~/.vimrc"

" install plugin manager vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Specify directory for plugins
call plug#begin('~/.vim/plugged')

" Section of plugins to install
" User Plug 'junegunn/vim-easy-align' to install plugins from github
" git clone git://github.com/Raimondi/delimitMate.git
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep' " Also 'apt install ripgrep'?
Plug 'tpope/vim-fugitive'
Plug 'lyuts/vim-rtags'
Plug 'git@github.com:ctrlpvim/ctrlp.vim' " An alternative would be git@github.com:junegunn/fzf
Plug 'git@github.com:Valloric/YouCompleteMe.git' " Also run 'sudo apt install build-essential cmake python3-dev' and './install.py --ts-completer --java-completer'
Plug 'mbbill/undotree'

" Initialize plugin system
call plug#end()
" Reload .vimrc and :PlugInstall to install plugins. See https://github.com/junegunn/vim-plug
" To uninstall a plugin remove its line reload vim and run :PlugClean. To update a plugin
" run : PlugUpdate. To upgrade plug itself run :PlugUpgrade


" If gruvbox plugin is install, sets gruvboc theme
"
colorscheme gruvbox
set background=dark

" not act like vi
set nocompatible
" set line numbers on the left side of the screen
set relativenumber number
" Highlight all search results
set hlsearch
" Ignore case in search
set ignorecase
" Show search results as yout type
set incsearch
set belloff=all
" Tab settings
set tabstop=4 softtabstop=4
set shiftwidth=4
" Auto indentation
set smartindent
" If search contains capital letter search case sensitive otherwise case insensitve
set showcmd
set smartcase
set wildmenu
set wildmode=list:longest,full

" Remap Esc to jk
inoremap jk <ESC>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" enable syntax highlighting and plugins (for netrw)
syntax enable
filetype plugin on

" Search down into subfolders
" Provides tab-completion for all file-related tasks
" just type :b or :find [filename] and use * 
set path+=**
" Display all matching files when we tab complete
set wildmenu

" TAG JUMPING:
" install ctags with: sudo apt install universal-ctags
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack
command! MakeTags !ctags -R .

" AUTOCOMPLETE:
" The good stuff is documented in |ins-completion|
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option
" - Use ^n and ^p to go back and forth in the suggestion list


let mapleader=" "

" FILE BROWSING:
if executable('rg')
	let g:rg_derive_root='true'
	"let g:ctrlp_user_command=['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'] 
	"let g:ctrlp_user_command=['rg %s --files --color=never --glob""'] 
	set grepprg=rg\ --color=never
	let g:ctrlp_user_command=['fdfind --type f -c never "" "%s"'] 
	let g:ctrlp_use_caching=0
	let g:ctrlp_working_path_mode='ra'
	let g:ctrlp_switch_buffer='et'
endif

let g:ctrlp_root_markers=['pom.xml']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(doc|tmp|node_modules|git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Tweaks for browsing
let g:netrw_winsize=25
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=2  " open file to the right of explorer
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" - :edit [filename] a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings 

" REMAPPINGS:
" Remap switching between windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
" fast quit
nnoremap <leader>q :q<CR>
" fast write
nnoremap <leader>w :w<CR>
" fast lex command
nnoremap <leader>e :Lex<CR>
" Project search with ripgrep
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
" Go to definition of current token
nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>
