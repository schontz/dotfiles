" plugin/open-github.vim - Open GitHub PR/issue/commit from reference under cursor
" Maintainer: David Schontzler
" License: MIT
" Version: 1.0.0

" Prevent loading twice
if exists('g:loaded_open_github')
  finish
endif
let g:loaded_open_github = 1

" Save user's cpoptions
let s:save_cpo = &cpo
set cpo&vim

" Define the commands
command! -nargs=0 OpenGithub call opengithub#Open()
command! -nargs=? OpenGithubCodeSearch call opengithub#Search(<q-args>)

" Create <Plug> mappings for user-defined mappings
nnoremap <silent> <Plug>(open-github) :call opengithub#Open()<CR>
nnoremap <silent> <Plug>(open-github-code-search) :call opengithub#Search('')<CR>

" Restore cpoptions
let &cpo = s:save_cpo
unlet s:save_cpo
