" vim configuration file
" __file__  .vimrc

scriptencoding utf-8
set encoding=utf-8

set nocompatible              " be iMproved, required
filetype off                  " required

set exrc                      " load vimrc from working directory
set secure                    " limit commands from non-default vimrc files


" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" PACKAGES

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'                   " let Vundle manage Vundle, required

Plugin 'vim-airline/vim-airline'                " status bar
Plugin 'vim-airline/vim-airline-themes'         " status bar colors
Plugin 'flazz/vim-colorschemes'                 " more colors
Plugin 'Yggdroot/indentLine'                    " show indentation levels
Plugin 'tpope/vim-fugitive'                     " git tools
Plugin 'xolox/vim-colorscheme-switcher'         " switch color w/ F8 / SHIFT F8
Plugin 'xolox/vim-misc'                         " dependency for ^
Plugin 'dantler/vim-alternate'                  " switch h/cpp (e.g. w/ `:A`)

Plugin 'severin-lemaignan/vim-minimap'          " show minimap sidebar

" install synastic?
"Plugin 'christoomey/vim-tmux-navigator'         " navigate tmux / vim splits
"Plugin 'git://github.com/majutsushi/tagbar.git' " class outline viewer

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" EDITOR

" also add this to .tmux.conf:    set -g default-terminal 'screen-256color'
set term=screen-256color   " fix colors for vim inside tmux

colorscheme herald

" show whitespace
"set listchars=trail:\uB7,nbsp:~,eol:\u23CE
"set list lcs=trail:\uB7,tab:\uBB\uB7
"set list lcs=trail:\uB7,tab:»·
"set list lcs=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ 
"set list lcs=trail:·,precedes:«,extends:»,eol:⏎,tab:▸\ 
set list lcs=tab:▸\ ,trail:·,precedes:«,extends:»
set number          " show line numbers
set hlsearch        " show highlighted search
set title           " show title in window bar
set cursorline      " highlight current line

" automatically load vimrc on change
augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

highlight ColorColumn ctermbg=0 guibg=lightgrey
call matchadd('ColorColumn', '\%81v', 88)          "only highlight when over


" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" LANGUAGES

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 softtabstop=4 cindent

" plugin 'indentLine' changes the 'conceallevel' from the default
" change the settings for json files so it doesn't squash characters
autocmd Filetype json let g:indentLine_enabled = 0

" use xml colors for ros launch
augroup roslaunch
	au!
	autocmd BufNewFile,BufRead *.launch   set syntax=xml
augroup END
"let g:indent_guides_enable_on_vim_startup = 1


" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" AIRLINE

set laststatus=2                      " show airline
let g:airline_highlighting_cache = 0  " make airline faster
let g:airline_powerline_fonts = 1     " enable symbols

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1

" airline unicode, requires:    # apt-get install fonts-powerline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" remove specific airline symbols to improve spacing / speed
let g:airline_symbols.linenr = ''  " ¶
let g:airline_symbols.maxlinenr = ''  " '
let g:airline_left_sep = ''  " 
let g:airline_right_sep = ''  " 

" airline formatting
let g:airline#extensions#whitespace#enabled = 0  " remove section on right
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'  " don't show encoding if utr-8