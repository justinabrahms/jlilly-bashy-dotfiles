. ~/.shell/aliases
. ~/.shell/completions
. ~/.shell/functions
. ~/.shell/prompt
. ~/.shell/variables
. ~/bin/virtualenvwrapper.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
. ~/.shell/host_specific
[[ -s "$HOME/.bash_local" ]] && . ~/.bash_local

# Run on new shell
if [ `which fortune` ]; then
    echo ""
    fortune
    echo ""
fi
