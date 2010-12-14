# Automatic options added
setopt appendhistory autocd nomatch autopushd pushdignoredups promptsubst
unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/jlilly/.zshrc'
# end automatic options

# Make prompt prettier
autoload -U promptinit
promptinit

. ~/.shell/aliases
. ~/.shell/completions
. ~/.shell/functions
. ~/.shell/prompt
. ~/.shell/variables
. ~/bin/virtualenvwrapper.sh
. ~/.shell/host_specific
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

# Run on new shell
have_fortune=`which fortune`
if [ -e have_fortune ]; then
    echo ""
    fortune
    echo ""
fi
