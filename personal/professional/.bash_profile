echo "Loading ~/.bash_profile"
export PATH="/apollo/env/SDETools/bin:$PATH"

test -f ~/.aliases && . $_

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export HISTSIZE=100000
export HISTFILESIZE=200000

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

#. $HOME/utils/z.sh

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
export PATH=$HOME/.toolbox/bin:$PATH
export PATH=/usr/local/gcc-9.1/bin:$PATH
