set nocompatible

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" VimPlug {{{
  " ensure vim-plug is installed and then load it
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  call plug#begin('~/.config/nvim/plugged')

  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-airline/vim-airline'
  " Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tpope/vim-surround'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '-> fzf#install()' }
  Plug 'junegunn/fzf.vim'

  " themes {{{
    " Plug 'tomasr/molokai'
    Plug 'dracula/vim', { 'name': 'dracula' }
    Plug 'mhartington/oceanic-next'
    Plug 'tomasiser/vim-code-dark'
    Plug 'nanotech/jellybeans.vim'
    Plug 'marcopaganini/termschool-vim-theme'
    Plug 'morhetz/gruvbox'
    Plug 'tomasr/molokai'
    Plug 'gosukiwi/vim-atom-dark'
    Plug 'jacoborus/tender.vim'
    Plug 'sjl/badwolf'
    Plug 'jdsimcoe/abstract.vim'
    Plug 'ayu-theme/ayu-vim'
    Plug 'tomasr/molokai'
    Plug 'AlessandroYorba/Sierra'
    Plug 'jaredgorski/SpaceCamp'
    Plug 'vim-scripts/wombat256.vim'
    Plug 'vim-scripts/twilight256.vim'
    Plug 'christophermca/meta5'
  " }}}

  " Syntax highlighting {{{
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/jsonc.vim' 
  " }}}

  " COC completion and extension
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'

  " Git goodness
  Plug 'tpope/vim-fugitive'

  " Find and replace
  " Plug 'brooth/far.vim'
  " Plug 'mileszs/ack.vim'

  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'scrooloose/nerdcommenter'

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
  nnoremap <leader>j :noh<CR><Left> " stop highlighting

  " Silent (no bells/beeps)
  set vb t_vb= 
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

  " Open images via Finder/Preview
  autocmd BufEnter *.png,*.jpg,*gif silent exec "!open ".expand("%") | :bw

  set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*

  set linebreak
" }}}

" Shortcuts {{{
  " open Finder/Explorer, open vimrc
  if has("win32")
    nnoremap <leader>e :silent execute '!explorer .'<CR>
    nnoremap <leader>vv :silent sp ~\_vimrc<CR>
    nnoremap <leader>vs :silent source ~\_vimrc<CR>
    nnoremap <leader>vg :silent sp ~\_gvimrc<CR>
  else
    nnoremap <leader>e :silent execute '!open .'<CR>
    nnoremap <leader>vv :silent sp ~/.vimrc<CR>
    nnoremap <leader>vs :silent source ~/.vimrc<CR>
    nnoremap <leader>vg :silent sp ~/.gvimrc<CR>
  endif

  " VS Code
  nnoremap <leader>co :silent execute '!code .'<CR>

  " CD to directory of current buffer (only for that buffer)
  nnoremap <leader>cd :silent call CDHere()<CR>:pwd<CR>
  if !exists("*CDHere")
    function CDHere()
      if bufname("") !~ "^\[A-Za-z0-9\]*://"
        lcd %:p:h:gs/ /\\ / 
      endif 
    endfunction
  endif

  " Ctrl+C copy
  vnoremap <C-c> "+y

  " Make Y behave like C and D
  nnoremap Y y$

  " Keep selection after indent/unindent
  " vnoremap > >gv
  " vnoremap < <gv

  " Pretty print JSON
  map <leader>on :silent :%!python -m json.tool<CR>

  " Save all
  command! W wall
  " Save and quit all
  if has('nvim')
    command! X wqa
  endif
  " Quit all
  command! Q qa

  " Zoom function
  nmap <leader>z <Plug>Zoom
" }}}

" Plugins {{{

  " Fugitive
  let g:fugitive_dynamic_colors = 0

  " COC {{{
    if filereadable($HOME . "/.config/nvim/cocrc.vim")
      source ~/.config/nvim/cocrc.vim
    endif
    let g:coc_fzf_preview = ''
  " }}}

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
    let g:airline#extensions#tabline#enabled = 1
    " let g:airline_theme='base16_shapeshifter'
    let g:airline_theme='base16_default'
    let g:airline#extensions#tabline#formatter = 'jsformatter'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
  " }}}

  let g:javascript_plugin_jsdoc = 1

  let g:far#source='rgnvim'

  " CtrlP {{{
    " let g:ctrlp_show_hidden = 1
    " let g:ctrlp_custom_ignore = {
    "   \ 'dir':  '\v[\/]\.?(CVS|node_modules|bower_components|git|hg|svn)$',
    "   \ 'file': '\v\.(exe|so|dll)$'
    "   \ }
    " let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
  " }}}

  " FZF {{{
    map <C-P> :Files<CR>
    map <leader>p :Buffers<CR>
    map <C-F> :execute 'Rg ' . input('Rg/')<CR>
    let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1 } }
    let $FZF_DEFAULT_OPTS = '--layout=default'
  " }}}

  " Far/Ack {{{
  " if executable('ag')
  "   let g:ackprg = 'ag --vimgrep'
  " endif
  " cnoreabbrev Ack Ack!
  " nnoremap <C-F> :Ack!<Space>
  " nnoremap <C-G> :AckFromSearch<Enter>
  " }}}

" }}}

" Theme and colors {{{
  if has("nvim")
    hi InactiveWindow ctermbg=237
    set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
  endif
  colorscheme wombat256mod
" }}}

" Manual syntax detection (vim-polyglot does most auto) {{{
  autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
" }}}
