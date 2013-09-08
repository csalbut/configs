set nocompatible
source $VIMRUNTIME/vimrc_example.vim
call pathogen#infect()
call pathogen#helptags()

" Gives some margin lines when scrolling up/down with cursor.
set scrolloff=3

set smartindent

set textwidth=80
" set columns=90

" Don't break lines in the middle of a word.
set linebreak

set formatoptions=tcq1

set shiftwidth=4
set softtabstop=4
"set expandtab		" Convert tabs to spaces.

set hidden

set number
set showbreak=------>\  " line up soft-wrap prefix with the line numbers
" set cpoptions+=n        " start soft-wrap lines (and any prefix) in the line-number area

" Paragraph formatting program
" set formatprg=par\ -w85

set nobackup
set noswapfile


" Source the vimrc file after saving it
if has("autocmd")
    if !exists("autocommands_loaded")
        let autocommands_loaded = 1
        autocmd bufwritepost _vimrc source $MYVIMRC
    endif
endif

" Open command line without Shift key.
nnoremap ; :

",v shortcut for editing vimrc
let mapleader = ","
nmap <leader>v :split $MYVIMRC<CR>
nmap <leader>fu :set formatoptions+=a<CR>
nmap <leader>fd :set formatoptions-=a<CR>
nmap <leader>w :w!<CR>
nmap <leader>q :q!<CR>
nmap <leader>x :x<CR>

" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP'[V']
vmap <C-Down> xp'[V']

" Underline a header with '=' characters.
nmap <F5> yypVr=

" Buffers navigation
nmap <C-Tab> :bnext<CR>
nmap <C-S-Tab> :bprev<CR>
nmap <leader>bw :bwipeout<CR>


set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

