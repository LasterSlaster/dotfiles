" Reload vimrc commands: ":so $MYVIMRC" or ":source ~/.vimrc"

" install plugin manager vim-plug
"if empty(glob('~/.vim/autoload/plug.vim'))
"  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif
"" Specify directory for plugins
"call plug#begin('~/.vim/plugged')
"
"" Section of plugins to install
"" User Plug 'junegunn/vim-easy-align' to install plugins from github
""
"" git clone git://github.com/Raimondi/delimitMate.git
"
"" Initialize plugin system
"call plug#end()
" Reload .vimrc and :PlugInstall to install plugins. See https://github.com/junegunn/vim-plug



" not act like vi
set nocompatible
" set line numbers on the left side of the screen
set number

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

" FILE BROWSING:
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" - :edit [filename] a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
