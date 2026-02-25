set nocompatible
set termguicolors

" Expect mise versions
" let g:coc_node_path = '~/.local/share/mise/shims/node'
" let g:python3_host_prog = '~/.local/share/mise/shims/python3'

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
    Plug 'josa42/nvim-lightline-lsp'
  " }}}

  " Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-unimpaired'

  " fzf
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '-> fzf#install()' }
  Plug 'junegunn/fzf.vim'
  Plug 'jesseleite/vim-agriculture'

  " themes
  Plug 'dracula/vim', { 'name': 'dracula' }
  Plug 'vim-scripts/wombat256.vim'
  Plug 'lifepillar/vim-solarized8'

  " Git goodness
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug '~/dev/github/github-extras.vim'

  " Preview CSS colors
  Plug 'chrisbra/Colorizer'

  if has("nvim")
    " Syntax highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'

    " NeoTree
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'nvim-neo-tree/neo-tree.nvim'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'ojroques/nvim-lspfuzzy'

    " Completion
    Plug 'saghen/blink.cmp', { 'tag': 'v1.*' }

    Plug 'folke/snacks.nvim'

    " Formatter
    Plug 'sbdchd/neoformat'
  else
    " Syntax highlighting
    Plug 'sheerun/vim-polyglot'

    " COC completion and extension
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'antoinemadec/coc-fzf'

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
  function! OpenInVSCode()
    let workspace = glob('*.code-workspace')
    if workspace != ''
      execute '!code ' . shellescape(workspace) . ' ' . shellescape(expand('%'))
    else
      execute '!code ' . shellescape(expand('%'))
    endif
  endfunction
  nnoremap <leader>co :silent call OpenInVSCode()<CR>

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

" GitHub extras
nmap <leader>gh <Plug>(open-github)

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

let g:colorizer_auto_filetype='less,css,html'

if has('nvim')
" NeoTree {{{{
  map <C-N> :Neotree toggle<CR>
  map <leader>nf :Neotree reveal<CR>

let use_lsp = 0
if (use_lsp == 1)
lua <<EOF
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
EOF
endif

lua <<EOF
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
EOF
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

let g:javascript_plugin_jsdoc = 1

" always show signcolumns
set signcolumn=yes

" FZF {{{
  map <C-P> :Files<CR>
  map <leader>p :Buffers<CR>
  let g:agriculture#rg_options = "--hidden"
  nmap <C-F> :execute 'RgRaw ' . input('RgRaw/')<CR>
  nmap <C-S-F> :execute 'Lines ' . input('Lines/')<CR>

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

" nvim-treesitter {{{
if has("nvim")
lua << EOF
local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

treesitter.setup {
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to install (or "all")
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "json",
    "html",
    "css",
    "lua",
    "vim",
    "vimdoc",
    "bash",
    "markdown",
    "markdown_inline",
    "python",
    "go",
    "rust",
    "yaml",
  },

  highlight = {
    enable = true,
    -- Disable vim-polyglot/syntax for files that treesitter handles
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },

  -- Incremental selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF
endif
" }}}

" nvim-lspconfig {{{
if has("nvim")
lua << EOF
-- Configure LSP floating windows with rounded borders
local border_style = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = border_style }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { border = border_style }
)

vim.diagnostic.config({
  float = { border = border_style },
  signs = {
    priority = 15,
    text = {
      [vim.diagnostic.severity.ERROR] = "❗",
      [vim.diagnostic.severity.WARN]  = "⚠️",
      [vim.diagnostic.severity.INFO]  = "ℹ",
      [vim.diagnostic.severity.HINT]  = "☼",
    },
  },
})

-- Customize completion popup appearance
vim.opt.pumblend = 10  -- Transparency (0-100, 0=opaque, 100=transparent)
vim.opt.pumheight = 15 -- Maximum number of items to show (default: 0 = all)

-- Enable TypeScript via the Language Server Protocol (LSP)
vim.lsp.enable('ts_ls')

-- LSP Keybindings (define first so we can use it in configs)
local lsp_keybindings_setup = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Function to check if a floating dialog exists and if not
  -- then check for diagnostics under the cursor
  function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    -- THIS IS FOR BUILTIN LSP
    vim.diagnostic.open_float(0, {
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
  end
  -- Show diagnostics under the cursor when holding position
  vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    command = "lua OpenDiagnosticIfNoFloat()",
    group = "lsp_diagnostics_hold",
  })

  -- Diagnostic navigation ([g and ]g)
  vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)

  -- Go-to mappings
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

  -- Hover documentation (K)
  vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover { border = "rounded", max_height = 25, max_width = 120 }
  end, opts)

  -- Rename (<leader>rn)
  vim.keymap.set('n', '<leader>rn', function()
    vim.ui.input({ prompt = 'Rename: ', default = vim.fn.expand('<cword>') }, function(new_name)
      if new_name and new_name ~= '' then
        vim.lsp.buf.rename(new_name)
      end
    end)
  end, opts)

  -- Format selected region (<leader>f)
  vim.keymap.set('x', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)

  -- Code actions
  vim.keymap.set('x', '<leader>af', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>af', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>qf', function()
    local picked = false
    vim.lsp.buf.code_action({
      apply = true,
      filter = function()
        if not picked then
          picked = true
          return true
        end
        return false
      end,
    })
  end, opts)

  -- Highlight symbol under cursor on CursorHold
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_document_highlight' })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- Set omnifunc to use LSP completion
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Make the on_attach function globally available
_G.lsp_keybindings_setup = lsp_keybindings_setup

-- Setup nvim-lspfuzzy (fuzzy finder for LSP functions)
require('lspfuzzy').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
 callback = function(args)
   local client = vim.lsp.get_client_by_id(args.data.client_id)
   if not client then
     return
   else
     client.request = require('lspfuzzy').wrap_request(client.request)
   end
 end
})

-- Commands (replaces :Format and :OR)
vim.api.nvim_create_user_command('Format', function()
  vim.lsp.buf.format()
end, {})

vim.api.nvim_create_user_command('OR', function()
  vim.lsp.buf.code_action({
    context = { only = { 'source.organizeImports' } },
    apply = true,
  })
end, {})

-- Enable and configure TypeScript LSP
vim.lsp.enable('ts_ls')
vim.lsp.config('ts_ls', {
  capabilities = lsp_capabilities,
  on_attach = lsp_keybindings_setup,
  init_options = {
    maxTsServerMemory = 12288, -- 12GB in megabytes
  },
})
EOF

set updatetime=300

endif
" }}}

" blink.cmp {{{
if has("nvim")
lua << EOF
require('blink.cmp').setup({
  fuzzy = {
    implementation = "prefer_rust"
  },

  keymap = {
    preset = 'default',
    ['<C-N>'] = { 'select_next', 'fallback' },
    ['<C-P>'] = { 'select_prev', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide' },
    ['<C-y>'] = { 'select_and_accept' },
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  completion = {
    accept = {
      auto_brackets = {
        enabled = false,
      },
    },
    menu = {
      auto_show = true,
      draw = {
        treesitter = { 'lsp' }
      }
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        border = 'rounded',
      },
    },
  },

  signature = {
    enabled = true,
    window = {
      border = 'rounded',
    }
  },
})
EOF
endif
" }}}

" snacks.nvim {{{
if has("nvim")
lua << EOF
require('snacks').setup({
  picker = { enabled = true },
  explorer = { enabled = true },
  input = {
    enabled = true,
    win = {
      relative = "cursor",
      row = -3,
      col = 0,
      keys = {
        i_esc = { "<esc>", "cancel", mode = "i" },
        i_c_a = { "<C-a>", function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Home>",  true, false, true), "n", false) end, mode = "i" },
        i_c_e = { "<C-e>", function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<End>",   true, false, true), "n", false) end, mode = "i" },
        i_c_b = { "<C-b>", function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>",  true, false, true), "n", false) end, mode = "i" },
        i_c_f = { "<C-f>", function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", false) end, mode = "i" },
        i_c_d = { "<C-d>", function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Del>",   true, false, true), "n", false) end, mode = "i" },
      },
    },
  },
})
EOF
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
    \               'lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings',
    \               'langclient_error', 'langclient_warning', 'langclient_hint', 'langclient_info',
    \               'linter_warnings', 'linter_errors' ],
    \             ['coc_status', 'nvlsp_status'] ],
    \ 'right': [ [ 'lineinfo' ],
    \            ['lsp_status'],
    \            [ 'fileformat', 'fileencoding', 'filetype' ], ],
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

    let g:diagnostic_enable_virtual_text = 1
    call sign_define("LspDiagnosticsErrorSign", {"text" : "E", "texthl" : "LspDiagnosticsError"})
    call sign_define("LspDiagnosticsWarningSign", {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
    call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
    call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})
    let g:diagnostic_virtual_text_prefix = '✘ '

    autocmd User CocDiagnosticChange call lightline#update()

    if has("nvim")
      call lightline#lsp#register()
    endif

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

" neoformat {{{
if (match(&rtp, 'neoformat') > -1)
  let g:neoformat_only_msg_on_error = 1
  let g:neoformat_try_node_exe = 1

  augroup fmt
    autocmd!
    autocmd BufWritePre * | Neoformat
  augroup END

  " Alias as :Prettier command
  command! -nargs=0 Prettier :Neoformat
endif
" }}}

" https://github.com/HerringtonDarkholme/yats.vim#config
set re=0

function! MakeSessionAndQuit()
  if has('nvim')
  else
    NERDTreeClose
  endif
  mksession! ~/.current_session.vim
  quit
endfunction

" MacVim
if has('gui')
  set guifont=Menlo-Regular:h20
  set background=dark
  colorscheme dracula

  set go+=!
  set lines=50 columns=140
  set wildmenu
  set wildmode=longest,list,full

  if empty(argv())
    cd ~/Desktop
  endif
endif
