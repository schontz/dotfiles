" autoload/opengithub.vim - Core functionality for opening GitHub PRs/issues/commits
" Maintainer: David Schontzler
" License: MIT

" Main entry point - intelligently opens PR/issue or commit under cursor
function! opengithub#Open() abort
  " Get the word under cursor (including punctuation)
  let l:word = expand('<cWORD>')

  " Try to extract PR/issue number first
  let l:pr_number = s:ExtractPRNumber(l:word)

  " If no PR/issue found, try commit hash
  if empty(l:pr_number)
    let l:commit_hash = s:ExtractCommitHash(l:word)

    if empty(l:commit_hash)
      echohl WarningMsg
      echo 'No PR/issue or commit found'
      echohl None
      return
    endif

    " Get GitHub repository info
    let l:repo = opengithub#GetGitHubRepo()

    if empty(l:repo)
      echohl WarningMsg
      echo 'Not a Github repo'
      echohl None
      return
    endif

    " Construct commit URL
    let l:url = 'https://github.com/' . l:repo . '/commit/' . l:commit_hash

    " Open the URL
    call opengithub#OpenURL(l:url)
    echo 'Opening: ' . l:url
    return
  endif

  " Get GitHub repository info
  let l:repo = opengithub#GetGitHubRepo()

  if empty(l:repo)
    echohl WarningMsg
    echo 'Not a Github repo'
    echohl None
    return
  endif

  " Construct PR URL
  let l:url = 'https://github.com/' . l:repo . '/pull/' . l:pr_number

  " Open the URL
  call opengithub#OpenURL(l:url)

  echo 'Opening: ' . l:url
endfunction

" Extract PR/issue number from text
" Supports patterns: #123, GH-123, gh-123
function! s:ExtractPRNumber(text) abort
  " Pattern 1: #123 or #12345
  let l:match = matchstr(a:text, '#\zs\d\+')
  if !empty(l:match)
    return l:match
  endif

  " Pattern 2: GH-123 or gh-123 (case-insensitive)
  let l:match = matchstr(a:text, '\c\<gh-\zs\d\+')
  if !empty(l:match)
    return l:match
  endif

  return ''
endfunction


" Extract commit hash from text
" Supports: 8-40 character hexadecimal strings with word boundaries
function! s:ExtractCommitHash(text) abort
  " Pattern: 8-40 hexadecimal characters with word boundaries
  let l:match = matchstr(a:text, '\<\x\{8,40}\>')
  return l:match
endfunction

" Parse .git/config and extract GitHub org/repo
function! opengithub#GetGitHubRepo() abort
  " Find git root directory
  let l:git_dir = s:FindGitRoot()

  if empty(l:git_dir)
    return ''
  endif

  let l:config_file = l:git_dir . '/.git/config'

  if !filereadable(l:config_file)
    return ''
  endif

  " Read config file
  let l:lines = readfile(l:config_file)

  " Try to find GitHub URL in origin remote first
  let l:repo = s:ParseGitHubURL(l:lines, 'origin')
  if !empty(l:repo)
    return l:repo
  endif

  " Fallback to upstream remote
  let l:repo = s:ParseGitHubURL(l:lines, 'upstream')
  return l:repo
endfunction

" Find git root directory starting from current file
function! s:FindGitRoot() abort
  let l:dir = expand('%:p:h')

  " If no file is open, use current working directory
  if empty(l:dir)
    let l:dir = getcwd()
  endif

  " Walk up directory tree looking for .git
  while l:dir !=# '/' && l:dir !=# ''
    if isdirectory(l:dir . '/.git')
      return l:dir
    endif
    let l:dir = fnamemodify(l:dir, ':h')
  endwhile

  " Also check current working directory
  if isdirectory(getcwd() . '/.git')
    return getcwd()
  endif

  return ''
endfunction

" Parse GitHub URL from git config lines for specified remote
function! s:ParseGitHubURL(lines, remote_name) abort
  let l:in_remote = 0

  for l:line in a:lines
    " Check if we're entering the target remote section
    if l:line =~# '^\[remote "' . a:remote_name . '"\]'
      let l:in_remote = 1
      continue
    endif

    " Check if we've entered a different section
    if l:line =~# '^\[' && l:in_remote
      let l:in_remote = 0
      continue
    endif

    " Look for URL in the current remote section
    if l:in_remote && l:line =~# '^\s*url\s*='
      let l:url = matchstr(l:line, 'url\s*=\s*\zs.*')
      let l:url = substitute(l:url, '^\s*\|\s*$', '', 'g')

      " Parse GitHub org/repo from URL
      let l:repo = s:ExtractGitHubRepo(l:url)
      if !empty(l:repo)
        return l:repo
      endif
    endif
  endfor

  return ''
endfunction

" Extract org/repo from GitHub URL
" Supports: https://github.com/org/repo.git
"          git@github.com:org/repo.git
function! s:ExtractGitHubRepo(url) abort
  " Check if it's a GitHub URL
  if a:url !~# 'github\.com'
    return ''
  endif

  let l:repo = ''

  " HTTPS format: https://github.com/org/repo.git
  let l:match = matchstr(a:url, 'github\.com/\zs[^/]\+/[^/]\+')
  if !empty(l:match)
    let l:repo = l:match
  endif

  " SSH format: git@github.com:org/repo.git
  if empty(l:repo)
    let l:match = matchstr(a:url, 'github\.com:\zs[^/]\+/[^/]\+')
    if !empty(l:match)
      let l:repo = l:match
    endif
  endif

  " Remove .git suffix if present
  let l:repo = substitute(l:repo, '\.git$', '', '')

  return l:repo
endfunction

" Open URL in system default browser
function! opengithub#OpenURL(url) abort
  let l:url = shellescape(a:url)

  if has('mac') || has('macunix')
    " macOS
    call system('open ' . l:url)
  elseif has('unix')
    " Linux
    call system('xdg-open ' . l:url . ' &')
  elseif has('win32') || has('win64')
    " Windows
    call system('start ' . l:url)
  else
    echohl ErrorMsg
    echo 'Unsupported platform for opening URLs'
    echohl None
  endif
endfunction
