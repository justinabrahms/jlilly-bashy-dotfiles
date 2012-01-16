. ~/.shell/aliases
. ~/.shell/functions
. ~/.shell/variables
. ~/.shell/host_specific
[[ -s "$HOME/.bash_local" ]] && . ~/.bash_local

if [ `which tmux` != "" -a "$PS1" != "" -a "$TMUX" == "" -a "${SSH_TTY:-x}" != x ]; then
        sleep 1
        ( (tmux has-session -t remote && tmux attach-session -t remote) || (tmux new-session -s remote) ) && exit 0
        echo "tmux failed to start"
fi

# Run on new shell
if [ `which fortune` ]; then
    echo ""
    fortune
    echo ""
fi
