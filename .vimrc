" set cindent


filetype plugin on

" auto-indent as I type
filetype indent on

"
" tab settings
"
set tabstop=4|set shiftwidth=4|set expandtab " default
set softtabstop=4
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab " Python
autocmd FileType make set tabstop=8|set shiftwidth=8|set noexpandtab " Makefile

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*


if &t_Co > 1
	"set t_Co=256
	"set t_AB=<ESC>[4%p1%dm
	"set t_AF=<ESC>3%p1%dm
	"hi Normal ctermfg=252 ctermbg=237 term=standout
	syntax enable
    colorscheme dw_yellow256
endif

" Highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Strip whitespace from source code
" autocmd FileType c,cpp,python,ruby,java,text,vhdl autocmd BufWritePre <buffer> :%s/\s\+$//e

" Turn on line numbers
set number

" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files

set modeline
