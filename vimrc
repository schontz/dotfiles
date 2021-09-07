set nocompatible
set termguicolors

let g:python2_host_prog = '~/.asdf/shims/python2'
let g:python3_host_prog = '~/.asdf/shims/python3'
let g:coc_node_path = '~/.asdf/shims/node'

" VimPlug {{{
  " ensure vim-plug is installed and then load it
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  call plug#begin('~/.config/nvim/plugged')

  " lightline {{{
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
  " }}}

  " Plug 'tpope/vim-surround'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '-> fzf#install()' }
  Plug 'junegunn/fzf.vim'

  " themes {{{
    Plug 'dracula/vim', { 'name': 'dracula' }
    Plug 'vim-scripts/wombat256.vim'
    Plug 'lifepillar/vim-solarized8'
    Plug 'tomasiser/vim-code-dark'
  " }}}

  " Syntax highlighting {{{
    Plug 'sheerun/vim-polyglot'
  " }}}

  " COC completion and extension
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'

  " Git goodness
  Plug 'tpope/vim-fugitive'

  Plug 'scrooloose/nerdtree'
  " Plug 'Xuyuanp/nerdtree-git-plugin'
  " Plug 'scrooloose/nerdcommenter'

  Plug 'airblade/vim-gitgutter'
  Plug 'moll/vim-bbye'

  " Load last
  Plug 'ryanoasis/vim-devicons'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'

  " All of your Plugins must be added before the following line
  call plug#end()			" required

  " To ignore plugin indent changes, instead use:
  "
  " Brief help
  " :PlugInstall    - installs plugins; append `!` to update or just :PluginUpdate
  " :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
  " :PlugStatus     - lists configured plugins and their statuses
  "
  " see :h vundle for more details or wiki for FAQ
  " Put your non-Plugin stuff after this line
" }}}

function! IsDarkMode()
  if has("macunix")
    let s = substitute(system('defaults read -g AppleInterfaceStyle 2>/dev/null'), '\n\+$', '', '')
    if s == "Dark"
      return 1
    else
      return 0
    endif
  else
    return 1
  endif
endfunction


" General {{{
  filetype plugin indent on
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
  let mapleader = ","

  " Detect background color
  if has("macunix")
    if split($COLORFGBG, ';')[1] > 8
      set background=light
    else
      set background=dark
    endif
  else
    set background=dark
  endif

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

  " Stop highlighting
  nnoremap <leader>j :noh<CR><Left>

  " Silent (no bells/beeps)
  set vb t_vb= 
  set belloff=all

  " Show preview on replace
  if has("nvim")
    set inccommand=nosplit
  endif

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

  " Open images via Finder/Preview
  autocmd BufEnter *.png,*.jpg,*gif silent exec "!open ".expand("%") | :bw

  set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store

  set linebreak
" }}}

" Shortcuts {{{
  " open Finder/Explorer, open vimrc
  if has("win32")
    nnoremap <leader>e :silent execute '!explorer .'<CR>
    nnoremap <leader>vv :silent e ~\_vimrc<CR>
    nnoremap <leader>vs :silent source ~\_vimrc<CR>
    nnoremap <leader>vg :silent e ~\_gvimrc<CR>
  else
    nnoremap <leader>e :silent execute '!open .'<CR>
    nnoremap <leader>vv :silent e ~/.vimrc<CR>
    nnoremap <leader>vs :silent source ~/.vimrc<CR>
    nnoremap <leader>vg :silent e ~/.gvimrc<CR>
  endif

  " VS Code
  nnoremap <leader>co :silent execute '!code . %'<CR>

  " CD to directory of current buffer (only for that buffer)
  nnoremap <leader>cd :silent call CDHere()<CR>:pwd<CR>
  function! CDHere()
    if bufname("") !~ "^\[A-Za-z0-9\]*://"
      lcd %:p:h:gs/ /\\ / 
    endif 
  endfunction

  " Ctrl+C copy
  vnoremap <C-c> "+y

  " Make Y behave like C and D
  nnoremap Y y$

  " Keep selection after indent/unindent
  " vnoremap > >gv
  " vnoremap < <gv

  " Pretty print JSON
  map <leader>on :silent :%!python -m json.tool<CR>

  " Save
  map <C-S> :w<CR>
  " Save all
  command! W wall
  " Save and quit all
  if has('nvim')
    command! X wqa
  endif
  " Quit all
  command! Q qa
  command! QQ qa!

  " Zoom function
  nmap <leader>z <Plug>Zoom
" }}}

" Fugitive
let g:fugitive_dynamic_colors = 0

" NERDTree {{{
  " function! NERDTreeToggleAndFind()
  "   if g:NERDTree.IsOpen()
  "     :NERDTreeToggle<CR>
  "   else
  "     :NERDTreeFind<CR>
  "   endif
  " endfunction

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

  " Add spaces after comment delimiters by default
  let g:NERDSpaceDelims = 1

  " Align line-wise comment delimiters flush left instead of following code indentation
  let g:NERDDefaultAlign = 'left'

" }}}

" Airline {{{
if (match(&rtp, 'vim-airline') > -1)
  let g:airline#extensions#tabline#enabled = 1
  " let g:airline_theme='base16_shapeshifter'
  let g:airline#extensions#tabline#formatter = 'jsformatter'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
endif
" if (match(&rtp, 'vim-airline-themes') > -1)
"   let g:airline_theme='base16_default'
" else
"   let g:airline_theme='dracula'
" endif
" }}}

let g:javascript_plugin_jsdoc = 1

" FZF {{{
  map <C-P> :Files<CR>
  map <leader>p :Buffers<CR>
  map <C-F> :execute 'Rg ' . input('Rg/')<CR>

  let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1 } }
  let $FZF_DEFAULT_OPTS = '--layout=default --color=' . &background
" }}}

" COC {{{
  if (match(&rtp, 'coc.nvim') > -1)
    if filereadable($HOME . "/.config/nvim/cocrc.vim")
      source ~/.config/nvim/cocrc.vim
    endif
    " Debug errors
    " let g:node_client_debug = 1
    let g:coc_fzf_preview = ''
  endif
" }}}

" Theme and colors {{{
  if has("nvim")
    set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
  endif

  if &background ==# 'light'
    colorscheme solarized8
  else
    " colorscheme wombat256mod
    colorscheme dracula
  endif
" }}}

" Lightline {{{
  if (match(&rtp, 'lightline') > -1)
    if filereadable($HOME . "/.config/nvim/statusline.vim")
      source ~/.config/nvim/statusline.vim
    else
      let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'coc_status': 'coc#status',
            \   'gitbranch': 'FugitiveHead',
            \ },
            \ }
    endif
  end
" }}}

" Manual syntax detection (vim-polyglot does most auto) {{{
  autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
" }}}

" https://github.com/HerringtonDarkholme/yats.vim#config
set re=0

function! MakeSessionAndQuit()
  NERDTreeClose
  mksession! ~/.current_session.vim
  quit
endfunction
