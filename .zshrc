# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch autopushd  pushdignoredups
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jlilly/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
PS1="%B%F{red}:%f%b %@ %B%F{red}:%f%b %B%F{blue}[%f%b%~%B%F{blue}]%f%b %n%B%F{blue}@%m%f%F{red};%f%b "


#  BEGINNING OF BASH PROFILE IMPORT

export PATH=$HOME/bin:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/opt/local/apache2/bin:/opt/local/apache/bin:/usr/local/bin:/usr/local/sbin:/usr/games:/usr/sbin:/usr/bin:/bin:/sbin:/Library/PostgreSQL/8.3/bin/:$PATH
export GDAL_DATA=/opt/local/share
export MANPATH=/opt/local/share/man:$MANPATH
export DISPLAY=:0.0

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31'
export EDITOR='emacsclient'
export GOOGLE_CODE_CHECKOUTS="$HOME/Code/trunks"

export HISTCONTROL=erasedups  # Ignore duplicate entries in history
export HISTSIZE=10000         # Increases size of history
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear:clr:[bf]g"

# ALAISES

# set some OS specific definitions
case $OSTYPE in
    *redhat*)
        # Redhat, which I use at work
        export PYTHONPATH=/usr/lib/python2.4/site-packages:$PYTHON_PATH
        export LS_COLORS='no=01:fi=01:di=01;35:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:';
        ini () {
            command sudo service $@
        }
        # this is really just so I have something to bellyache about
        alias agi="time sudo yum -C install"
        alias acs="time sudo yum -C search"
        alias acsh="time sudo yum -C info"
        alias ls="ls -F --color"
        export GOOGLE_CODE_CHECKOUTS="/opt/trunks/"
        export EDITOR='vim'
        ;;
    *linux*)
        # Linux Specific
        export PYTHONPATH=$PYTHONPATH:/Users/jlilly/Code/django:/Library/Python/2.5/site-packages:/Users/jlilly/Code/django:/Library/Python/2.5/site-packages
        export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31;00:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
        export EDITOR='emacsclient'
        ini () {
            command sudo /etc/init.d/$@
        }
        alias agi="sudo apt-get install"
        alias acs="sudo apt-cache search"
        alias acsh="sudo apt-cache show"
        alias aguu="sudo apt-get update && sudo apt-get upgrade"
        alias ls="ls -F --color"       # Color is handled differently on Linux
        ;;
    *darwin*)
        # Mac Specific
        export PATH=/Applications/Emacs.app/Contents/MacOS/bin:$PATH
        export PYTHONPATH=$PYTHONPATH:/Users/jlilly/Code/django:/Library/Python/2.5/site-packages:/Users/jlilly/Code/trunks/pinax/apps:/Users/jlilly/Code/django/pinax/local_apps:/Users/jlilly/Code/python:/Users/jlilly/Code/trunks:/opt/local/lib/python2.5/site-packages:
        export EMACSLOADPATH=~/.emacs.d:/Applications/MacPorts/Emacs.app/Contents/Resources/lisp:/Applications/MacPorts/Emacs.app/Contents/Resources/site-lisp:/opt/local/share/emacs/site-lisp:/Applications/Emacs.app/Contents/Resources/lisp:/Applications/Emacs.app/Contents/Resources/site-lisp:
        export LSCOLORS='Gxfxcxdxdxegedabagacad'
        export WORKON_HOME="$HOME/.virtualenvs"
        alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
        alias agi='sudo port install'
        alias acs='sudo port list'
        alias aguu='sudo port -d selfupdate'
        alias ls='ls -GFp'          # Compact view, show colors

        . ~/Code/django-trunk/extras/django_bash_completion

        ;;
    *)
        ;;
esac

# Configs that rely on stuff in the case statement
export VISUAL=$EDITOR
export SVN_EDITOR=$VISUAL
export GIT_EDITOR=$VISUAL

# Global
# Filesystem
alias ..='cd ..'            # Go up one directory
alias ...='cd ../..'        # Go up two directories
alias l='ls -lah'           # Long view, show hidden
alias la='ls -AF'           # Compact view, show hidden
alias ll='ls -lFh'          # Long view, no hidden

# Helpers
alias grep='grep --color=auto' # Always highlight grep search term
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited
alias df='df -h'            # Disk free, in gigabytes, not bytes
alias du='du -h -c'         # Calculate total disk usage for a folder
alias sgi='sudo gem install' # Install ruby stuff

# Nifty extras
alias irc="ssh justinlilly.com"
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"
alias clr='clear;echo "Currently logged in on $(tty), as $(whoami) in directory $(pwd)."'
alias pypath='python -c "import sys; print sys.path" | tr "," "\n" | grep -v "egg"'
alias pycclean='find . -name "*.pyc" -exec rm {} \;'

# GIT ALIASES
alias ga='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias gsd='git svn dcommit'
alias gsr='git svn rebase'
alias gs='git stash'
alias gsa='git stash apply'
alias gr='git stash && git svn rebase && git svn dcommit && git stash apply' # git refresh
alias gd='git diff | $GIT_EDITOR -'
alias gmv='git mv'
alias gho='$(git remote -v 2> /dev/null | grep github | sed -e "s/.*git\:\/\/\([a-z]\.\)*/\1/" -e "s/\.git$//g" -e "s/.*@\(.*\)$/\1/g" | tr ":" "/" | tr -d "\011" | sed -e "s/^/open http:\/\//g")'

# HG ALIASES
alias hgst='hg status'
alias hgd='hg diff | $GIT_EDITOR -'

# SVN ALIASES
gcco () {
    svn checkout http://$@.googlecode.com/svn/trunk/ $GOOGLE_CODE_CHECKOUTS/$@
}

## Functions

svim () {
    # Run vim as super user
    command sudo vim $@
}

emc () {
    emacsclient $@ &
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)        tar xjf $1        ;;
            *.tar.gz)         tar xzf $1        ;;
            *.bz2)            bunzip2 $1        ;;
            *.rar)            unrar x $1        ;;
            *.gz)             gunzip $1         ;;
            *.tar)            tar xf $1         ;;
            *.tbz2)           tar xjf $1        ;;
            *.tgz)            tar xzf $1        ;;
            *.zip)            unzip $1          ;;
            *.Z)              uncompress $1     ;;
            *)                echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

dict() {
    grep "$@" /usr/share/dict/words
}
dls () {
 # directory LS
 echo `ls -l | grep "^d" | awk '{ print $9 }' | tr -d "/"`
}
dgrep() {
    # A recursive, case-insensitive grep that excludes binary files
    grep -iR "$@" * | grep -v "Binary"
}
dfgrep() {
    # A recursive, case-insensitive grep that excludes binary files
    # and returns only unique filenames
    grep -iR "$@" * | grep -v "Binary" | sed 's/:/ /g' | awk '{ print $1 }' | sort | uniq
}
psgrep() {
    if [ ! -z $1 ] ; then
        echo "Grepping for processes matching $1..."
        ps aux | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

killit() {
    # Kills any process that matches a regexp passed to it
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

tree () {
    find $@ -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

mcd () {
    mkdir "$@" && cd "$@"
}

exip () {
    # gather external ip address
    echo -n "Current External IP: "
    curl -s -m 5 http://myip.dk | grep "<title>" | sed -e 's/<title>Your IP address is: //g' -e 's/<\/title>//g'
}

ips () {
    # determine local IP address
    ifconfig | grep "inet " | awk '{ print $2 }'
}

gsvn () {
     cat .git/config | grep url
}

parse_git_branch(){ 
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /';
}

parse_svn_rev(){ 
    svn info 2> /dev/null | grep "Revision" | sed 's/Revision: \(.*\)/[r\1] /';
}


ORIG_PS1=$PS1

source $HOME/bin/virtualenvwrapper_bashrc

has_virtualenv() {
    if [ -e .venv ]; then
        workon `cat .venv`
    fi
}
venv_cd () {
    cd "$@" && has_virtualenv
}
alias cd="venv_cd"

# Welcome Message
echo -e ""
echo -ne "Today is "; date
echo -e ""; cal;
echo -ne "Up time: ";uptime | awk /'up/ {print $3,$4}'
echo "";
fortune
