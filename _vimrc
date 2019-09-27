set nocompatible
filetype off
set encoding=utf-8

let $PATH='C:\Python27;'.$PATH

" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'neoclide/coc.nvim'
" Plugin 'pangloss/vim-javascript'
" Plugin 'mxw/vim-jsx'
" Plugin 'leafgarland/typescript-vim'
" Plugin 'ianks/vim-tsx'
Plugin 'sheerun/vim-polyglot'
" Plugin 'fholgado/minibufexpl.vim'

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

" execute pathogen#infect()
behave mswin
" Ctrl+C copy
vnoremap <C-c> "+y

" Ctrl+V paste in insert mode
set pastetoggle=<F10>
inoremap <C-v> <F10><C-r>+<F10>

" source $VIMRUNTIME/mswin.vim
set linebreak

if empty(argv())
	cd c:\dev
endif

source ~/_vimrc.base.vim

" set laststatus=2
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

autocmd BufNewFile,BufRead C:/dev set ff=unix

map <C-n> :NERDTreeToggle<CR>
" let NERDTreeShowHidden=1
" let NERDTreeQuitOnOpen=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='molokai'
let g:airline#extensions#tabline#formatter = 'jsformatter'

let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']

let g:javascript_plugin_jsdoc = 1

" Launch a command line
map <F2> :!start cmd /k cd %:p:h<CR>

" Get rif of mixed linebreaks
if !exists("*FixEOLs")
	function FixEOLs()
		:%s/$//g
	endfunction
endif

map <F7> :call FixEOLs()<CR>
map <F7><F7> :call FixEOLs()<CR>:w<CR>

function! FixAMV()
	if &ff == "dos"
		:%s/\%xFF/\r/ge
		:%s/\\u00ff/\r/ge
	else
		:%s/\%xFF/\n/ge
		:%s/\\u00ff/\n/ge
	endif
endfunction

map <F3> :call FixAMV()<CR>

map ,js :silent :%!python -m json.tool<CR> " Pretty print JSON

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.?(CVS|node_modules|bower_components|git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['CVS']

autocmd BufRead,BufNewFile *.log setlocal filetype=winston

" Projects
" Why projects? So I can use ':find' and 'gf', that's why!
if has("win32")
	" for wiki:links when using 'gf'
	set includeexpr=substitute(v:fname,'wiki:\\(\\/\\?[a-zA-Z0-9_\\-\\/]\\+\\/\\)\\?','','g')

	if !exists("project")
		let project='-no project-'
	endif

	function! PickProject(name, ...)
		if a:0 > 0
			let force = a:1
		else
			let force = 0
		endif

		if g:project == '-no project-' || force == 1
			if a:name == 'cadsrc'
				set path=c:/dev/_head/cadsrc/client/**
				cd c:/dev/_head/cadsrc/client
				let g:project='CAD'
			elseif a:name == 'hsisrc'
				set path=c:/dev/_head/hsisrc/js/**
				cd c:/dev/_head/hsisrc/js
				let g:project='HSI'
			elseif a:name == 'maps'
				set path=c:/dev/_mobilemaps/cadsrc/client_mobilemaps/**
				cd c:/dev/_mobilemaps/cadsrc/client_mobilemaps
				let g:project='MobileMaps'
			endif
		endif

		" FIXME: how do I make this always print but not require an Enter
		" to continue when I open a file?
		if a:name == '-' || force == 1
			echo "Project: " . g:project
		endif
	endfunction

	" Show current project
	map ,pr :call PickProject('-')<CR>
	" Search these extensions, foo
	set suffixesadd=.js,.xml,.html,.htm,.css,.rest

	" (C)adsrc
	map ,pc :call PickProject('cadsrc', 1)<CR>
	au BufNewFile,BufRead c:/dev/cadsrc/client/* call PickProject('cadsrc')

	" (H)sisrc
	map ,ph :call PickProject('hsisrc', 1)<CR>
	au BufNewFile,BufRead c:/dev/hsisrc/js/* call PickProject('hsisrc')

	" (M)obileMaps
	map ,pm :call PickProject('maps', 1)<CR>
	au BufNewFile,BufRead c:/dev/cadsrc/client_mobilemaps/* call PickProject('maps')
endif " end win32
