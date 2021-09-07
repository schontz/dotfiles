set guifont=HackNerdFontComplete-Regular:h22
if IsDarkMode()
  set background=dark
  colorscheme dracula
else
  set background=light
  colorscheme=solarized8
endif

set go+=!
set lines=50 columns=140
set wildmenu
set wildmode=longest,list,full

if empty(argv())
  cd ~/Desktop
endif

