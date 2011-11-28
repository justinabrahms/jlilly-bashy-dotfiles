. ~/.shell/aliases
. ~/.shell/functions
. ~/.shell/variables
. ~/.shell/host_specific
[[ -s "$HOME/.bash_local" ]] && . ~/.bash_local

# Run on new shell
if [ `which fortune` ]; then
    echo ""
    fortune
    echo ""
fi
