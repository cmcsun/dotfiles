" My .vimrc
set nocompatible              " be iMproved, required
filetype off                  " required 

" to do: re-add dragvisuals.vim and edit the configuration in this part!~:
runtime plugin/dragvisuals.vim
vmap <expr> h   DVB_Drag('left')
vmap <expr> l   DVB_Drag('right')
vmap <expr> j   DVB_Drag('down')
vmap <expr> k   DVB_Drag('up')

" Install VimPlug -- curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" vimplug
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.nvim/plugged/gocode/vim/symlink.sh' }
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'neomake/neomake'
Plug 'kassio/neoterm'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'zchee/deoplete-go', { 'do': 'make'}
"#Plug '

call plug#end()

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let mapleader = ","
let maplocalleader = "m"

"let g:deoplete#sources#go#gocode_binary

" heavy tmux integration
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" dont hide whitespace from our python plugin
let g:pymode_trim_whitespaces = 0
let g:pymode_motion = 0
let g:pymode_options_max_line_length = 79
let g:pymode_options_colorcolumn = 1
let g:pymode_folding = 0

" the absolute most important stuff is here
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

" wip
map <F5> :make
map <F6> :copen
map <F7> :cclose

" must haves
set ignorecase
syntax on
syntax enable

" show line numbers when i press f4 (this works in any mode)
highlight LineNr ctermbg=0 ctermfg=5
nmap <silent> <F4> :set invnumber<CR>
imap <silent> <F4> <ESC>:set invnumber<CR>i

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

" Make 81st colum stand out for if line is too long (usually never see this
" cuz i split screen a lot with tmux but if i was coding full screen this will
" show up sometimes

    " OR ELSE just the 81st column of wide lines...
    highlight ColorColumn ctermbg=magenta
    call matchadd('ColorColumn', '\%81v', 100)

" Make tabs, trailing whitespace, and non-breaking spaces visible

"#exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
 "   set list


" make ; and : do the same thing

    nnoremap  ;  :

" Always turn on syntax highlighting for diffs
" this is neat for a few different reasons
    " EITHER select by the file-suffix directly...
    augroup PatchDiffHighlight
        autocmd!
        autocmd BufEnter  *.patch,*.rej,*.diff   syntax enable
    augroup END

" column border highlighting, turned off for now
 highlight ColorColumn ctermbg=0
" execute "set colorcolumn=" . join(range(81,335), ',')

filetype plugin on
au FileType c setl ofu=ccomplete#CompleteCpp
let g:ycm_confirm_extra_conf = '/home/methos/.vim/.ycm_extra_conf.py'

" python
filetype indent plugin on


" when to activate neomake
call neomake#configure#automake('nrw', 50)

" which linter to enable for Python source file linting
let g:neomake_python_enabled_makers = ['pylint']

let g:neomake_python_pylint_maker = {
  \ 'args': [
  \ '-d', 'C0103, C0111',
  \ '-f', 'text',
  \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
  \ '-r', 'n'
  \ ],
  \ 'errorformat':
  \ '%A%f:%l:%c:%t: %m,' .
  \ '%A%f:%l: %m,' .
  \ '%A%f:(%l): %m,' .
  \ '%-Z%p^%.%#,' .
  \ '%-G%.%#',
  \ }

let g:neomake_python_enabled_makers = ['flake8', 'pylint']

