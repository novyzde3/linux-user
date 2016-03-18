
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup  " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif

set history=100 " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
set smartcase   " ignore case pro vyhledavani
set number      " number lines

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" if has('mouse')
"   set mouse=a
" if

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
	  au!

	  " For all text files set 'textwidth' to 78 characters.
	  autocmd FileType text setlocal textwidth=78

	  " When editing a file, always jump to the last known cursor position.
	  " Don't do it when the position is invalid or when inside an event handler
	  " (happens when dropping a file on gvim).
	  " Also don't do it when the mark is in the first line, that is the default
	  " position when opening a file.
	  autocmd BufReadPost *
				  \ if line("'\"") > 1 && line("'\"") <= line("$") |
				  \   exe "normal! g`\"" |
				  \ endif
  augroup END
endif " has("autocmd")


set expandtab     " don't use actual tab character (ctrl-v)
set autoindent    " zachovava odsazeni podle predchozi radky
set smartindent   " odsazeni podle programovani (zvetsuje)
set pastetoggle=<f5>
set tabstop=3     " pocet sloupcu tabu
set expandtab     " expanduje taby na mezery
set shiftwidth=3  " odsazeni programu (pri pouziti treba '=')
" set softtabstop=3 " velikost tabu pri nenastaveni ostatnich

" tab completion in <:cmd>
set wildmenu
set wildmode=list:longest,full

" For pasting in source formatting (ale pak nefunguji zkratky)
" set paste

" Zapnuti <:set paste> pouze pri vkladani
" <:set paste> znamena nefunkcni zkratky v insert mode
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Kodovani
set enc=utf8


" Swap and backup directories
" Create directories
let vimdir=expand('~/.vim/')
let backupdir=vimdir.'/backups//'
let swapdir=vimdir.'/swap//'
if !isdirectory(backupdir)
   silent execute expand('!mkdir -p ' . backupdir)
endif " !isdirectory(backupdir)
if !isdirectory(swapdir)
   silent execute expand('!mkdir -p ' . swapdir)
endif " !isdirectory(swapdir)

execute expand ('set backupdir=') . backupdir . ',.'
execute expand ('set directory=') . swapdir   . ',.'


" Zkratky
" <ZZ> ulozit  azavrit
" <C-x><C-e> v bash otevre EDITOR a umozni napsat tmp skript
" <F2> otevre nove podokno (rozdeli)

map  <F2> <c-w>v<c-w>w
imap <F2> <esc><c-w>v<c-w>wa

" <F3> duplikace zalozky
map  <F3>   :tabe %<cr>
map  <F3>   <esc>:tabe %<cr>a

" <F4> zavre podokno
map  <F4> <c-w>q
imap <F4> <esc><c-w>qa

" <S-tab> <tab> posuny po oknech
map  <tab> <c-w>w
nnoremap <S-Tab> <c-w>r
inoremap <S-Tab> <esc><c-w>ra

" <F10> format souboru
map  <F10> ggVG=''
imap <F10> ggVG=''i

" <F12> ulozeni souboru
map  <F12> :w<cr>
imap <F12> <esc>:w<cr>a

" <M-PageDown> <M-PageUp> pohyb mezi zalozkami
map  <M-PageDown>   :tabn<CR>
map  <M-PageUp>     :tabp<CR>
imap <M-PageDown>   <esc>:tabn<CR>a
imap <M-PageUp>     <esc>:tabp<CR>a



" ### LaTex ###
" zkratky pro kompilaci LateXu - CTRL + l
"map <C-l> :w<cr> :execute '! bibtex '. expand('%:p:h') . '/*.aux'<cr> :execute '! pdflatex ' . expand('%:p:h') . '/*.tex'<cr>
"imap <C-l> <esc>:w<cr> :execute '! bibtex '. expand('%:p:h') . '/*.aux'<cr> :execute '! pdflatex ' . expand('%:p:h') . '/*.tex'<cr>a
map <C-l> :w<cr> :execute '! bibtex *.aux && pdflatex *.tex && pdflatex *.tex'<cr>
imap <C-l> <esc>:w<cr> :execute '! bibtex *.aux && pdflatex *.tex && pdflatex *.tex'<cr>a
imap <C-e> \emph{}<esc>i
imap <C-r> \texttt{}<esc>i
imap <C-a> \_

" ### Graphviz ###
" zkratka pro kompilaci Graphvizu CTRL + g
map <C-g> :w<cr> :execute '! dot -Tps *.dot -O'<cr>
imap <C-g> <esc>:w<cr> :execute '! dot -Tps *.dot -O'<cr>i


" Ctrl-j/k maze prazdne radky pred/za a Alt-j/k je pridava.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>


" ### VISUAL MODE ###
" // - vyhleda oznacene
"vnoremap // y/<C-R>"<CR>


" ### NORMAL MODE ###
" <esc> - zrusi oznaceni
nnoremap <esc><esc> :nohl<cr>

" ===== Vim LaTex =====
" Plugin latex-suite for Latex sources in vim
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
" =======================


