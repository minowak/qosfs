" vundle config "
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" vundle plugins "
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'

" end vundle config "
call vundle#end()
filetype plugin indent on

" numbered lines "
set number
" autoindentation "
set autoindent
" use local .vimrc if exists "
set exrc
" restriction for running shell commands "
set secure
" indentation rules "
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" maximum line width indicator "
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" assume all .h files to be C instead of CPP and add doxygen highlighting "
augroup project
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

" path for <C-W> <C-F> "
let &path.="src/include,/usr/include/AL,"

" nerd tree settings "
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() ==0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" autocomplete configuration "
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

