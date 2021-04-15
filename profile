export PATH=/opt/local/bin:/opt/local/sbin:$PATH

function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/<git:\1> /'
}
PS1='\[\e[1;35m\][\u:\w]\[\e[m\] \[\e[36m\]$(git_branch)\[\e[m\] \n$ '
