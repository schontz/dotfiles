set nocompatible
filetype off
set encoding=utf-8

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'fatih/molokai'
Plugin 'lifepillar/vim-solarized8'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'neoclide/coc.nvim'
Plugin 'brooth/far.vim'
Plugin 'mileszs/ack.vim'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree-project-plugin'
" Load last
Plugin 'ryanoasis/vim-devicons'
Plugin 'vwxyutarooo/nerdtree-devicons-syntax'

" All of your Plugins must be added before the following line
call vundle#end()			" required
filetype plugin indent on	" required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype on
syntax enable
set nu
set hidden
set nobackup
set nowritebackup
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
set autoindent
set incsearch
set ignorecase smartcase
set hlsearch
set mouse=a
set encoding=utf-8
set cursorline

filetype plugin indent on

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

let mapleader = ","

" Scroll
nnoremap <C-K> <C-Y>
nnoremap <C-J> <C-E>

" Buffer switching
nnoremap <C-L> :bn<CR>
nnoremap <C-H> :bp<CR>

" Quick movement between panes
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Making things better...
nnoremap <leader>j :noh<CR><Left> " stop highlighting
set vb t_vb= " set silent (no beep)
set belloff=all

" Make backspace like other programs
set backspace=indent,eol,start

" no .swp mayhem
if exists("$TEMP")
	set directory=$TEMP
elseif exists("$TMP")
	set directory=$TMP
else
	set directory=/tmp
endif

" Shortcuts
if has("win32")
	nnoremap <leader>e :silent execute '!explorer .'<CR> " Launch Explorer
	nnoremap <leader>vv :silent sp ~\_vimrc<CR> " Edit vimrc
	nnoremap <leader>vs :silent source ~\_vimrc<CR> " Source (re-apply) vimrc
	nnoremap <leader>vg :silent sp ~\_gvimrc<CR> " Edit gvimrc
else
	nnoremap <leader>e :silent execute '!open .'<CR> " Launch Finder
	nnoremap <leader>vv :silent sp ~/.vimrc<CR> " Edit vimrc
	nnoremap <leader>vs :silent source ~/.vimrc<CR> " Source (re-apply) vimrc
	nnoremap <leader>vg :silent sp ~/.gvimrc<CR> " Edit gvimrc
endif

" CD to directory of current buffer (only for that buffer)
nnoremap <leader>cd :silent call CDHere()<CR>:pwd<CR>
if !exists("*CDHere")
	function CDHere()
		if bufname("") !~ "^\[A-Za-z0-9\]*://"
			lcd %:p:h:gs/ /\\ / 
		endif 
	endfunction
endif

" Cmd+C copy
vnoremap <D-c> "+y

" Cmd+V paste in insert mode
set pastetoggle=<F10>
inoremap <D-v> <F10><C-r>+<F10>

set linebreak

" Get rif of mixed linebreaks
if !exists("*FixEOLs")
	function FixEOLs()
		:%s/$//g
	endfunction
endif

map <F7> :call FixEOLs()<CR>
map <F7><F7> :call FixEOLs()<CR>:w<CR>

map <leader>on :silent :%!python -m json.tool<CR> " Pretty print JSON

" ### BEGIN PLUGIN SETTINGS ###

" COC config
if filereadable($HOME . "/.vim/cocrc.vim")
  source ~/.vim/cocrc.vim
endif

" set laststatus=2
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

map <C-n> :NERDTreeToggle<CR>
" let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
" Close when the last open tab is NERDTree 
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['^node_modules$[[dir]]']
map <leader>nn :NERDTreeProjectLoadFromCWD<CR>
map <leader>nf :NERDTreeFind<CR>
" Open NERDTree if no file is passed
if !has("gui_running")
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='molokai'
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline_powerline_fonts = 1

let g:javascript_plugin_jsdoc = 1

let g:far#source='rgnvim'

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.?(CVS|node_modules|bower_components|git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }
let g:ctrlp_user_command = ['./git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Add :Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Open images via Finder/Preview
" :autocmd BufEnter *.png,*.jpg,*gif exec "! ~/.iterm2/imgcat ".expand("%") | :bw
:autocmd BufEnter *.png,*.jpg,*gif exec "!open ".expand("%") | :bw
