export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

source /etc/profile # runs automatically (or so it seems)
source ~/.alias
source ~/.profile

##
# Your previous /Users/schontz/.bash_profile file was backed up as /Users/schontz/.bash_profile.macports-saved_2012-01-12_at_16:00:23
##

# MacPorts Installer addition on 2012-01-12_at_16:00:23: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# add PostgreSQL bins to path
PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"


# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
. "$HOME/.cargo/env"
