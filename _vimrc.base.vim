filetype on
syntax enable
set nu
set hidden
set nobackup
set nowritebackup
set tabstop=3
set sw=3
set smarttab
set autoindent
set incsearch
set ignorecase smartcase
set hlsearch
set mouse=a
set encoding=utf-8
set cursorline

filetype plugin indent on

" Scroll
noremap <C-K> <C-Y>
noremap <C-J> <C-E>

" Buffer switching
map <C-h> :bp<CR>
map <C-l> :bn<CR>

" Making things better...
map ,j :noh<CR><Left> " stop highlighting
set vb t_vb= " set silent (no beep)
set belloff=all

" Make backspace like other programs
set backspace=indent,eol,start

" Shortcuts
if has("win32")
	map ,e :silent execute '!explorer .'<CR> " Launch Explorer
	map ,vv :silent sp ~\_vimrc<CR> " Edit vimrc
	map ,vs :silent source ~\_vimrc<CR> " Source (re-apply) vimrc
	map ,vg :silent sp ~\_gvimrc<CR> " Edit gvimrc
	map ,us :silent sp c:\\dev\\useful.md<CR>
else
	map ,vv :silent sp ~/.vimrc<CR> " Edit vimrc
	map ,vs :silent source ~/.vimrc<CR> " Source (re-apply) vimrc
endif

" no .swp mayhem
if exists("$TEMP")
	set directory=$TEMP
elseif exists("$TMP")
	set directory=$TMP
else
	set directory=/tmp
endif

map ,cd :silent call CDHere()<CR>:pwd<CR> " CD to directory of current buffer (only for that buffer)
if !exists("*CDHere")
	function CDHere()
		if bufname("") !~ "^\[A-Za-z0-9\]*://"
			lcd %:p:h:gs/ /\\ / 
		endif 
	endfunction
endif

autocmd BufRead,BufNewFile *.log setlocal filetype=winston

