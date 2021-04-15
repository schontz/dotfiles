let debug_coc = 0

if (debug_coc == 1)
  call plug#begin('~/.config/nvim/plugged')
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-airline/vim-airline'
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-surround'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '-> fzf#install()' }
  Plug 'junegunn/fzf.vim'
    Plug 'sheerun/vim-polyglot'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
    Plug 'tpope/vim-fugitive'
  call plug#end()

  source ~/.cocrc.vim

  nnoremap <leader>vv :silent sp ~/.config/nvim/init.vim<CR>
  nnoremap <leader>vs :silent source ~/.config/nvim/init.vim<CR>

  " FZF {{{
  if (match(&rtp, 'fzf.vim') > -1)
    map <C-P> :Files<CR>
    map <leader>p :Buffers<CR>
    map <C-F> :execute 'Rg ' . input('Rg/')<CR>
    let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1 } }
    let $FZF_DEFAULT_OPTS = '--layout=default'
  endif
  " }}}

  let g:node_client_debug = 1

  colo desert

  echo "COC debug mode"
else
  source /Users/dschontz/.vimrc
endif

