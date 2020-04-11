"     s                                          .x+=:.      .
"    :8                                         z`    ^%    @88>
"   .88                  .u    .                   .   <k   %8P
"  :888ooo      .u     .d88B :@8c       .u       .@8Ned8"    .
"-*8888888   ud8888.  ="8888f8888r   ud8888.   .@^%8888"   .@88u
"  8888    :888'8888.   4888>'88"  :888'8888. x88:  `)8b. ''888E`
"  8888    d888 '88%"   4888> '    d888 '88%" 8888N=*8888   888E
"  8888    8888.+"      4888>      8888.+"     %8"    R88   888E
" .8888Lu= 8888L       .d888L .+   8888L        @8Wou 9%    888E
" ^%888*   '8888c. .+  ^"8888*"    '8888c. .+ .888888P`     888&
"   'Y"     '88888%       'Y'       '88888%   `   ^"F       R888"
"             'YP'                    'YP'                   ''

set encoding=utf-8
scriptencoding utf-8
set nocompatible              " be iMproved, required
filetype off                  " required
set exrc                      " load vimrc from working directory
set secure                    " limit commands from non-default vimrc files


" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" PACKAGES

set rtp+=~/.vim/bundle/Vundle.vim               " add vundle to runtime path
call vundle#begin()                             " initialize vundle
"call vundle#begin('~/some/path/here')          " or set a plugin install dir

Plugin 'VundleVim/Vundle.vim'                   " let Vundle manage Vundle, required

Plugin 'vim-airline/vim-airline'                " status bar
Plugin 'vim-airline/vim-airline-themes'         " status bar colors
Plugin 'flazz/vim-colorschemes'                 " more colors
Plugin 'Yggdroot/indentLine'                    " show indentation levels
Plugin 'tpope/vim-fugitive'                     " git tools
Plugin 'xolox/vim-colorscheme-switcher'         " switch color w/ F8 / SHIFT F8
Plugin 'xolox/vim-misc'                         " dependency for ^
Plugin 'dantler/vim-alternate'                  " switch h/cpp (e.g. w/ `:A`)
Plugin 'scrooloose/syntastic'                   " syntax checking
Plugin 'airblade/vim-gitgutter'                 " show git status +/0 on side
Plugin 'rhysd/vim-clang-format'                 " format C w/ `:ClangFormat`

Plugin 'severin-lemaignan/vim-minimap'          " show minimap sidebar

"Plugin 'christoomey/vim-tmux-navigator'         " navigate tmux / vim splits
"Plugin 'git://github.com/majutsushi/tagbar.git' " class outline viewer

call vundle#end()            " required, all plugins must be added before this
filetype plugin indent on    " required


" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" SHORTCUTS

" split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" EDITOR

" also add this to .tmux.conf:    set -g default-terminal 'screen-256color'
set term=screen-256color   " fix colors for vim inside tmux

silent! colorscheme ron
silent! colorscheme herald

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

set tw=0             " do not automatically break lines at certain length

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" NAVIGATION

set path+=**                     " add working dir to search :find
set wildmenu                     " turn on tab completion for :find
set wildignore+=**/.git/**       " ignore git folders
set hidden                       " allow buffer switch w/o save


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
" SYNTASTIC

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0              " 0: close quickfix window on startup
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0

function! ToggleSyntastic()
    let g:syntastic_auto_loc_list = 1          " 1: re-enable quickfix window
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            lclose
            return
        endif
    endfor
    SyntasticCheck
endfunction
nnoremap <F9> :call ToggleSyntastic()<CR>


" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" AIRLINE
set laststatus=2                      " show airline
let g:airline_highlighting_cache = 0  " make airline faster
let g:airline_powerline_fonts = 1     " enable symbols

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1        " enable list of buffers
let g:airline#extensions#tabline#fnamemod = ':t'    " show just filename in buffer list
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
let g:airline_symbols.branch = ''  " ''

" airline formatting
let g:airline#extensions#whitespace#enabled = 0  " remove section on right
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'  " don't show encoding if utf-8


