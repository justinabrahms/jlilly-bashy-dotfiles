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
