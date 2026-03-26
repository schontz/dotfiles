" sessions.vim
" =============
" Auto-save and restore Vim sessions per working directory.
"
" OVERVIEW
" --------
" Each time you exit Vim, the current session is saved to ~/.vimsessions/
" using a filename derived from the working directory. The next time you open
" Vim in the same directory, you can restore your buffers, splits, and folds
" with a single command.
"
" STORAGE
" -------
" Sessions are saved to:
"
"   ~/.vimsessions/<encoded-cwd>.vim
"
" The CWD is encoded by replacing '/' with '%', e.g.:
"
"   /Users/you/dev/myproject  ->  %Users%you%dev%myproject.vim
"
" The sessions directory is created automatically if it does not exist.
"
" COMMANDS
" --------
"   :SessionLoad    Source the session file for the current working directory.
"                   Prints a warning if no session exists yet.
"   :SessionDelete  Delete the session file for the current working directory.
"                   Prints a warning if no session exists yet.
"
" MAPPINGS
" --------
" No default key mappings are set. To add one, put this in your config:
"
"   nmap <leader>ls <Plug>SessionLoad
"
" HOOKS
" -----
" A User autocommand event fires just before the session is written:
"
"   autocmd User SessionSavePre <your command>
"
" Use this to close plugin buffers (e.g. NERDTree, neo-tree) that should not
" be part of the saved session. Example:
"
"   autocmd User SessionSavePre Neotree close
"
" BEHAVIOR
" --------
" - Sessions are saved automatically on exit via VimLeavePre.
" - If no named buffers are open, the session is not saved (avoids writing
"   empty sessions when opening Vim without files).
" - The following is saved per session: buffers, cwd, tab pages, window
"   sizes, and folds. The 'options' value is intentionally excluded to avoid
"   persisting plugin state across sessions."

if exists('g:loaded_sessions')
  finish
endif
let g:loaded_sessions = 1

let s:save_cpo = &cpo
set cpo&vim

let s:sessions_dir = expand('~/.vimsessions/')

function! s:SessionFile() abort
  return s:sessions_dir . substitute(getcwd(), '/', '%', 'g') . '.vim'
endfunction

function! s:SaveSession() abort
  " Skip if no named buffers are open
  if empty(filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) != ""'))
    return
  endif
  if !isdirectory(s:sessions_dir)
    call mkdir(s:sessions_dir, 'p')
  endif
  silent doautocmd User SessionSavePre
  execute 'mksession! ' . fnameescape(s:SessionFile())
endfunction

function! s:LoadSession() abort
  let l:file = s:SessionFile()
  if filereadable(l:file)
    execute 'source ' . fnameescape(l:file)
    echo 'Session loaded: ' . l:file
  else
    echohl WarningMsg
    echo 'No session found for: ' . getcwd()
    echohl None
  endif
endfunction

augroup sessions
  autocmd!
  autocmd VimLeavePre * call s:SaveSession()
augroup END

function! s:DeleteSession() abort
  let l:file = s:SessionFile()
  if filereadable(l:file)
    call delete(l:file)
    echo 'Session deleted: ' . l:file
  else
    echohl WarningMsg
    echo 'No session found for: ' . getcwd()
    echohl None
  endif
endfunction

command! -nargs=0 SessionLoad call s:LoadSession()
command! -nargs=0 SessionDelete call s:DeleteSession()

nnoremap <silent> <Plug>SessionLoad :<C-U>call <SID>LoadSession()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
