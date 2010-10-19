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
. ~/.bash_local

# Run on new shell
if [ `which fortune` ]; then
    echo ""
    fortune
    echo ""
fi
