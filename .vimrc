" Methos's .vimrc
set nocompatible              " be iMproved, required
filetype off                  " required
" vundle + plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim' "vundle itself
Plugin 'FredKSchott/CoVim'
Plugin 'Valloric/YouCompleteMe' "autocomplete
call vundle#end()            " required
filetype plugin indent on    " required

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
set background=dark
filetype plugin on
set autoindent
set cindent
set clipboard=unnamed       " use system clipboard
set pastetoggle=<F2>        " paste mode
set expandtab
set smarttab
set tabstop=4
set incsearch
set hlsearch
set ignorecase smartcase    " make searches case-sensitive only if they got a cap in them
set shiftwidth=4
set softtabstop=4
set bs=2
set encoding=utf8
set ffs=unix,dos,mac
set mouse=a

map <F5> :make
map <F6> :copen
map <F7> :cclose

set ignorecase
syntax on
syntax enable

" show line numbers when i press f4
highlight LineNr ctermbg=0 ctermfg=5
nmap <silent> <F4> :set invnumber<CR>
imap <silent> <F4> <ESC>:set invnumber<CR>i

" allow file saving as root when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" crappy hex editor
nmap <silent> <F8> :call Edithex()<CR>
nmap <silent> <F9> :set nobinary<CR>:set eol<CR>

function Edithex()
    set binary
    set noeol
    if $hex_input == 1
        :%!xxd -r
        let $hex_input = 0
    else
        :%!xxd
        let $hex_input = 1
    endif
endfunction

" Tabs
nnoremap <C-t> :tabnew<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

"====[ Make the 81st column stand out ]====================

    " EITHER the entire 81st column, full-screen...
    highlight ColorColumn ctermbg=magenta
    set colorcolumn=81

    " OR ELSE just the 81st column of wide lines...
    highlight ColorColumn ctermbg=magenta
    call matchadd('ColorColumn', '\%81v', 100)

    " OR ELSE on April Fools day...
    highlight ColorColumn ctermbg=red ctermfg=blue
    exec 'set colorcolumn=' . join(range(2,80,3), ',')


"=====[ Highlight matches when jumping to next ]=============

    " This rewires n and N to do the highlighing...
    nnoremap <silent> n   n:call HLNext(0.4)<cr>
    nnoremap <silent> N   N:call HLNext(0.4)<cr>


    
    "highlight the match in red...makes a blink
    function! HLNext (blinktime)
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#\%('.@/.'\)'
        let ring = matchadd('WhiteOnRed', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        call matchdelete(ring)
        redraw
    endfunctio

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set list


"====[ Swap : and ; to make colon commands easier to type ]======

    nnoremap  ;  :
    nnoremap  :  ;


"====[ Swap v and CTRL-V, because Block mode is more useful that Visual mode "]======

    nnoremap    v   <C-V>
    nnoremap <C-V>     v

    vnoremap    v   <C-V>
    vnoremap <C-V>     v


"====[ Always turn on syntax highlighting for diffs ]=========================

    " EITHER select by the file-suffix directly...
    augroup PatchDiffHighlight
        autocmd!
        autocmd BufEnter  *.patch,*.rej,*.diff   syntax enable
    augroup END

    " OR ELSE use the filetype mechanism to select automatically...
    filetype on
    augroup PatchDiffHighlight
        autocmd!
        autocmd FileType  diff   syntax enable
    augroup EN

" column border highlighting, turned off for now
 highlight ColorColumn ctermbg=0
" execute "set colorcolumn=" . join(range(81,335), ',')

filetype plugin on
au FileType c setl ofu=ccomplete#CompleteCpp

