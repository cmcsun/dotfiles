" My .vimrc
set nocompatible              " be iMproved, required
filetype off                  " required 


" to do: re-add dragvisuals.vim and edit the configuration in this part!~:
runtime plugin/dragvisuals.vim
vmap <expr> h   DVB_Drag('left')
vmap <expr> l   DVB_Drag('right')
vmap <expr> j   DVB_Drag('down')
vmap <expr> k   DVB_Drag('up')
set rtp+=/home/cmc/.config/nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")
Plugin 'VundleVim/Vundle.vim'  " required
call vundle#end()            " required
filetype plugin indent on    " required
" vimplug
call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nfrid/treesitter-utils'
Plug 'nfrid/markdown-togglecheck'
Plug 'cuducos/yaml.nvim'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" For luasnip users.
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'

" For ultisnips users.
" Plug 'SirVer/ultisnips'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" For snippy users.
" Plug 'dcampos/nvim-snippy'
" Plug 'dcampos/cmp-snippy'
call plug#end()
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence


set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes


" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice

if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let $CACHE = expand('~/.cache')
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    let s:dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/Shougo/dein.vim' s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endif

let mapleader = ","
let maplocalleader = "m"

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
set incsearch
set hlsearch
set ignorecase smartcase    " make searches case-sensitive only if they got a cap in them
set shiftwidth=4
set bs=2
set encoding=utf8
set ffs=unix,dos,mac
set mouse=a

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
" Make 81st colum stand out for if line is too long (usually never see this
" cuz i split screen a lot with tmux but if i was coding full screen this will
" show up sometimes

    " OR ELSE just the 81st column of wide lines...
    highlight ColorColumn ctermbg=magenta
    call matchadd('ColorColumn', '\%81v', 100)



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

" python
filetype indent plugin on


" when to activate neomake
"call neomake#configure#automake('nrw', 50)

" which linter to enable for Python source file linting
"let g:neomake_python_enabled_makers = ['pylint']

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
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
