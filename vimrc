set nocompatible
filetype off
set encoding=utf-8

" ensure vim-plug is installed and then load it
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'sheerun/vim-polyglot' " all lang syntax

" Themes
" Plug 'tomasr/molokai'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'mhartington/oceanic-next'
" Plug 'chriskempson/base16-vim'
" Plug 'tomasiser/vim-code-dark'
" Plug 'nanotech/jellybeans.vim'
" Plug 'marcopaganini/termschool-vim-theme'

" COC completion and extension
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-fugitive'

" Find and replace
Plug 'brooth/far.vim'
Plug 'mileszs/ack.vim'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree-project-plugin'

Plug 'airblade/vim-gitgutter'
Plug 'moll/vim-bbye'

" Plug 'sickill/vim-monokai'

" Load last
Plug 'ryanoasis/vim-devicons'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'

" All of your Plugins must be added before the following line
call plug#end()			" required

filetype plugin indent on	" required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PlugInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" :PlugStatus     - lists configured plugins and their statuses
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

" ### Theme and colors ###
if has("nvim")
  hi InactiveWindow ctermbg=237
  set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endif
" if (has("termguicolors"))
  " set termguicolors
" endif
" colorscheme OceanicNext
" ###

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

" Deoplete
let g:deoplete#enable_at_startup = 1


" COC config
if filereadable($HOME . "/.vim/cocrc.vim")
  source ~/.vim/cocrc.vim
endif


" set laststatus=2
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*


" ### NERDTree ###
map <C-n> :NERDTreeToggle<CR>
let NERDTreeRespectWildIgnore=1
let NERDTreeShowHidden=1
" let NERDTreeQuitOnOpen=1
" Close when the last open tab is NERDTree 
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['^node_modules$[[dir]]']
map <leader>nn :NERDTreeProjectLoadFromCWD<CR>
map <leader>nf :NERDTreeFind<CR>
" How can I make sure vim does not open files and other buffers on NerdTree window?
" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='base16_shapeshifter'
let g:airline_theme='base16_default'
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:javascript_plugin_jsdoc = 1

let g:far#source='rgnvim'

let g:ctrlp_show_hidden = 1

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

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
nnoremap <C-F> :Ack!<Space>
nnoremap <C-G> :AckFromSearch<Enter>

nmap <leader>z <Plug>Zoom

