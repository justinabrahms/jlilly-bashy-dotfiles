# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# OLD: ZSH_THEME="smt"
ZSH_THEME='kennethreitz'

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew github virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

# -- Custom configs --


# Automatic options added
setopt appendhistory autocd nomatch autopushd pushdignoredups promptsubst
unsetopt beep correctall
bindkey -e
zstyle :compinstall filename '/home/jlilly/.zshrc'
# end automatic options

# Make prompt prettier
autoload -U promptinit
promptinit

. ~/.shell/aliases
. ~/.shell/completions
. ~/.shell/functions
. ~/.shell/variables
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
. /usr/local/Cellar/autojump/21.6.9/etc/autojump.zsh
