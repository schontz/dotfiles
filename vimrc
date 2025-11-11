set nocompatible
set termguicolors

" Expect mise versions
let g:coc_node_path = '~/.local/share/mise/shims/node'
let g:python3_host_prog = '~/.local/share/mise/shims/python3'

" VimPlug {{{
  " ensure vim-plug is installed and then load it
  if has('gui')
    " MacVim plugin location
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
  else
    " Neovim plugin location
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
  endif
  call plug#begin('~/.config/nvim/plugged')

  " lightline {{{
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
  " }}}

  " Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'

  " Plug 'neovim/nvim-lspconfig'
  " Plug 'pmizio/typescript-tools.nvim'
  " Plug 'hrsh7th/nvim-cmp'
  " Plug 'stevearc/conform.nvim'
  " Plug 'nvim-lua/plenary.nvim'
  " Plug 'neovim/nvim-lspconfig'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '-> fzf#install()' }
  Plug 'junegunn/fzf.vim'

  " themes {{{
    Plug 'dracula/vim', { 'name': 'dracula' }
    Plug 'vim-scripts/wombat256.vim'
    Plug 'lifepillar/vim-solarized8'
  " }}}

  " Syntax highlighting {{{
    Plug 'sheerun/vim-polyglot'
  " }}}

  " COC completion and extension
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'

  " Git goodness
  Plug 'tpope/vim-fugitive'

  " Preview CSS colors
  Plug 'chrisbra/Colorizer'

  if has("nvim")
    " NeoTree
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'nvim-neo-tree/neo-tree.nvim'
  else
    " NerdTree
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'scrooloose/nerdcommenter'
  endif

  Plug 'airblade/vim-gitgutter'
  Plug 'moll/vim-bbye'

  Plug 'christoomey/vim-tmux-navigator'

  Plug 'farconics/victionary'

  " Plug 'wellle/context.vim'

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
  if !empty($COLORFGBG)
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

  " Quick movement between panes
  " nnoremap <C-J> <C-W><C-J>
  " nnoremap <C-K> <C-W><C-K>
  " nnoremap <C-L> <C-W><C-L>
  " nnoremap <C-H> <C-W><C-H>

  " Stop highlighting
  nnoremap <leader>j :noh<CR><Left>

  " Toggle word wrap
  nnoremap <leader>ww :set wrap!<CR>

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

  function! Browse()
    :G browse %
  endfunction

  " TODO: How to get a:lineno to work?
  " function! BrowseLine(lineno = line('.'))
  "   :G browse-line % `a:lineno`
  " endfunction

  nnoremap <leader>gb :silent call Browse()<CR>

  " Ctrl+C copy
  vnoremap <C-c> "+y

  " Make Y behave like C and D
  nnoremap Y y$

  " Keep selection after indent/unindent
  " vnoremap > >gv
  " vnoremap < <gv

  " Pretty print JSON
  map <leader>on :silent :%!python3 -m json.tool<CR>

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

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

let g:colorizer_auto_filetype='less,css,html'

if has('nvim')
" NeoTree {{{{
  map <C-N> :Neotree toggle<CR>
  map <leader>nf :Neotree reveal<CR>

let use_lsp = 0
if (use_lsp == 1)
lua <<LUA
      require('lspconfig').eslint.setup({
        settings = {
          packageManager = 'yarn'
        },
        ---@diagnostic disable-next-line: unused-local
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })
LUA

lua <<LUA
      require("typescript-tools").setup({
        on_attach =
            function(client, _)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end,
        settings = {
          jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
          }
        }
      })
LUA
endif

lua <<LUA
  require("neo-tree").setup({
    enable_git_status = true,
    sort_case_insensitive = false,
    default_component_configs = {
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
    },
    window = {
      mappings = {
        ["o"] = "open"
      }
    },
    filesystem = {
      group_empty_dirs = true,
      window = {
        mappings = {
          ["o"] = "open"
        }
      },
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show = { ".git", ".DS_Store" },
      },
    },
    source_selector = {
      statusline = true
    }
  })
LUA
" }}}}
else
" NERDTree {{{
  function! NERDTreeToggleAndFind()
    if g:NERDTree.IsOpen()
      :NERDTreeToggle<CR>
    else
      :NERDTreeFind<CR>
    endif
  endfunction

  map <C-n> :NERDTreeToggle<CR>
  let NERDTreeRespectWildIgnore=1
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=1
  " Close when the last open tab is NERDTree 
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
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
endif

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

  let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.6, 'yoffset': 1 } }
  let $FZF_DEFAULT_OPTS = '--layout=default --color=' . &background
" }}}

" COC {{{
  if (match(&rtp, 'coc.nvim') > -1)
    " Install these extensions
    let g:coc_global_extensions = [
      \'coc-prettier',
      \'coc-json',
      \'coc-jest',
      \'coc-cssmodules',
      \'coc-tsserver',
      \'coc-css',
      \'@yaegassy/coc-vitest'
    \]

    " Better display for messages
    set cmdheight=1

    " You will have bad experience for diagnostic messages when it's default 4000.
    set updatetime=300

    " don't give |ins-completion-menu| messages.
    set shortmess+=c

    " always show signcolumns
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    " inoremap <silent><expr> <TAB>
    "      \ pumvisible() ? "\<C-n>" :
    "      \ <SID>check_back_space() ? "\<TAB>" :
    "      \ coc#refresh()
    " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    " Use <cr> to confirm completion
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " To make <cr> select the first completion item and confirm the completion when no item has been selected:
    " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice.
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Close the preview window when completion is done.
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>af <Plug>(coc-codeaction-selected)
    nmap <leader>af <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    " nmap <silent> <C-d> <Plug>(coc-range-select)
    " xmap <silent> <C-d> <Plug>(coc-range-select)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    " command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <leader>dg  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    " Add :Prettier command
    command! -nargs=0 Prettier :CocCommand prettier.formatFile

    " Jest
    " Run jest for current project
    command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

    " Run jest for current file
    command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

    " Run jest for current test
    nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>

    " Vitest
    " Run Vitest for current project
command! -nargs=0 Vitest :call CocAction('runCommand', 'vitest.projectTest')

" Run Vitest for current file
command! -nargs=0 VitestCurrent :call  CocAction('runCommand', 'vitest.fileTest', ['%'])

" Run Vitest for single (nearest) test
nnoremap <leader>ve :call CocAction('runCommand', 'vitest.singleTest')<CR>

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

  function! ToggleDarkMode()
    if &background ==# 'light'
      set background=dark
      colorscheme dracula
    else
      set background=light
      colorscheme solarized8
    endif
  endfunction
  nnoremap <leader>tt :call ToggleDarkMode()<CR><Left>
" }}}

" Lightline {{{
  if (match(&rtp, 'lightline') > -1)
    set noshowmode

    let s:symbolE = '✘'
    let s:symbolW = '⚠'
    let s:symbolI = 'ℹ'
    let s:symbolH = '💡'

    let s:theme = 'wombat'
    if &background ==# 'light'
      let s:theme = 'solarized'
    endif


    let g:lightline = {
    \ 'colorscheme': s:theme,
    \ 'active': {
    \   'left': [ [ 'platform' ], [ 'mode', 'paste' ],
    \             [ 'git', 'readonly', 'filename', 'modified',
    \               'coc_error', 'coc_warning', 'coc_hint', 'coc_info',
    \               'langclient_error', 'langclient_warning', 'langclient_hint', 'langclient_info',
    \               'linter_warnings', 'linter_errors' ],
    \             ['coc_status', 'nvlsp_status'] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'tabline': {
    \   'left': [ ['buffers'] ],
    \   'right': [ ['close'] ]
    \ },
    \ 'component': {
    \   'lineinfo': '%l:%v/%L',
    \ },
    \ 'component_function': {
    \   'git': 'LightlineGit',
    \   'readonly': 'LightlineReadonly',
    \   'fileformat': 'LightlineFileformat',
    \   'fileencoding': 'LightlineFileencoding',
    \   'coc_status': 'LightlineCocStatus',
    \   'linter_warnings': 'LightlineLinterWarnings',
    \   'linter_errors': 'LightlineLinterErrors',
    \   'platform': 'LightlinePlatform',
    \ },
    \ 'component_expand': {
    \   'nvlsp_status': 'LightLineNeovimLspStatus',
    \   'linter_warnings': 'LightlineLinterWarnings',
    \   'linter_errors': 'LightlineLinterErrors',
    \   'langclient_error'        : 'Lightlinelang_clientErrors',
    \   'langclient_warning'      : 'Lightlinelang_clientWarnings',
    \   'langclient_info'         : 'Lightlinelang_clientInfos',
    \   'langclient_hint'         : 'Lightlinelang_clientHints',
    \   'coc_error'        : 'LightlineCocErrors',
    \   'coc_warning'      : 'LightlineCocWarnings',
    \   'coc_info'         : 'LightlineCocInfos',
    \   'coc_hint'         : 'LightlineCocHints',
    \   'coc_fix'          : 'LightlineCocFixes',
    \   'buffers': 'lightline#bufferline#buffers',
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
    \}

    let g:lightline.component_type = {
    \   'linter_errors'    : 'error',
    \   'linter_warnings'  : 'warning',
    \   'coc_error'        : 'error',
    \   'coc_warning'      : 'warning',
    \   'coc_info'         : 'tabsel',
    \   'nvlsp_status'     : 'raw',
    \   'coc_hint'         : 'middle',
    \   'coc_fix'          : 'middle',
    \   'buffers'          : 'tabsel',
    \ }

    set showtabline=2

    function! s:lightline_coc_diagnostic(kind, sign) abort
      let info = get(b:, 'coc_diagnostic_info', 0)
      if empty(info) || get(info, a:kind, 0) == 0
        return ''
      endif
      return printf('%s%d', a:sign, info[a:kind])
    endfunction

    function! LightlineCocErrors() abort
      return s:lightline_coc_diagnostic('error', s:symbolE)
    endfunction
    function! LightlineCocWarnings() abort
      return s:lightline_coc_diagnostic('warning', s:symbolW)
    endfunction
    function! LightlineCocInfos() abort
      return s:lightline_coc_diagnostic('information', s:symbolI)
    endfunction
    function! LightlineCocHints() abort
      return s:lightline_coc_diagnostic('hint',s:symbolH)
    endfunction
    function! LightlineCocStatus() abort
      return get(g:, 'coc_status', '')
    endfunction

    function! LightlinePlatform()
      return has('macunix') == '1' ? '' : has('win32') == '1' ? '' : ''
    endfunction

    function! LightlineFileformat()
      return &fileformat !=# 'unix' ? &fileformat : ''
    endfunction

    function! LightlineFileencoding()
      return &fileencoding !=# 'utf-8' ? &fileencoding : ''
    endfunction

    function! LightlineReadonly()
      return &readonly && &filetype !=# 'help' ? '🔒' : ''
    endfunction

    function! LightlineGit()
      let branch = FugitiveHead()
      if branch ==# ''
          return ''
      endif
      let [a,m,r] = GitGutterGetHunkSummary()
      let s = ' '
      if a != 0
        let s = s . printf('+%d', a)
      endif
      if m != 0
        let s = s . printf('~%d', m)
      endif
      if r != 0
        let s = s . printf('-%d', r)
      endif
      " if s ==# ' '
      "     return branch
      " endif
      return (' ' . branch[:10] . s)
    endfunction

    function! LightlineLinterWarnings() abort
      let l:counts = ale#statusline#Count(bufnr(''))
      let l:all_errors = l:counts.error + l:counts.style_error
      let l:all_non_errors = l:counts.total - l:all_errors
      return l:counts.total == 0 ? '' : printf('%d '.s:symbolW, all_non_errors)
    endfunction

    function! LightlineLinterErrors() abort
      let l:counts = ale#statusline#Count(bufnr(''))
      let l:all_errors = l:counts.error + l:counts.style_error
      let l:all_non_errors = l:counts.total - l:all_errors
      return l:counts.total == 0 ? '' : printf('%d '.s:symbolE, all_errors)
    endfunction

    function! LightlineLinterOK() abort
      let l:counts = ale#statusline#Count(bufnr(''))
      let l:all_errors = l:counts.error + l:counts.style_error
      let l:all_non_errors = l:counts.total - l:all_errors
      return l:counts.total == 0 ? '✓' : ''
    endfunction


    function! s:lightline_langclient_diagnostic(kind, sign) abort
      let info = LanguageClient#statusLineDiagnosticsCounts()
      if empty(info) || get(info, a:kind, 0) == 0
        return ''
      endif
      return printf('%s%d', a:sign, info[a:kind])
    endfunction

    function! Lightlinelang_clientErrors() abort
      return s:lightline_langclient_diagnostic('E', s:symbolE)
    endfunction
    function! Lightlinelang_clientWarnings() abort
      return s:lightline_langclient_diagnostic('W', s:symbolW)
    endfunction
    function! Lightlinelang_clientInfos() abort
      return s:lightline_langclient_diagnostic('I', s:symbolI)
    endfunction
    function! Lightlinelang_clientHints() abort
      return s:lightline_langclient_diagnostic('H',s:symbolH)
    endfunction

    " Statusline
    function! LightLineNeovimLspStatus() abort
      if !exists(':LspInstallInfo')
        return ''
      endif
      if luaeval('#vim.lsp.buf_get_clients() > 0')
        return substitute(luaeval("require('lsp-status').status()"), '%', '%%', 'g') 
      endif

      return ''
    endfunction

    " echo nvim_treesitter#statusline(90)

    let g:diagnostic_enable_virtual_text = 1
    call sign_define("LspDiagnosticsErrorSign", {"text" : "E", "texthl" : "LspDiagnosticsError"})
    call sign_define("LspDiagnosticsWarningSign", {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
    call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
    call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})
    let g:diagnostic_virtual_text_prefix = '✘ '

    autocmd User CocDiagnosticChange call lightline#update()

    let g:lightline#bufferline#filename_modifier = ':s?\/index\.\(js\|jsx\|ts\|tsx\)$?.i?:t'
    let g:lightline#bufferline#smart_path=0
  end
" }}}

" victionary {{{
  let g:victionary#map_defaults = 0
  nmap <leader>di <Plug>(victionary#define_under_cursor)
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

" MacVim
if has('gui')
  set guifont=Menlo-Regular:h19
  set background=dark
  colorscheme dracula
  " if IsDarkMode()
  "   set background=dark
  "   colorscheme dracula
  " else
  "   set background=light
  "   colorscheme solarized8
  " endif

  set go+=!
  set lines=50 columns=140
  set wildmenu
  set wildmode=longest,list,full

  if empty(argv())
    cd ~/Desktop
  endif
endif
