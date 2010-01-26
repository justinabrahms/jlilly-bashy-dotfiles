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
shopt -s histappend        # Append history instead of overwriting
shopt -s cdspell           # Correct minor spelling errors in cd command
shopt -s dotglob           # includes dotfiles in pathname expansion
shopt -s checkwinsize      # If window size changes, redraw contents
shopt -s cmdhist           # Multiline commands are a single command in history.
shopt -s extglob           # Allows basic regexps in bash.
set ignoreeof on           # Typing EOF (CTRL+D) will not exit interactive sessions

if [ -e ~/.bashrc ]; then
    . ~/.bashrc
fi

# ALAISES

# set some OS specific definitions
case $MACHTYPE in
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
        export LS_COLORS="di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=32;38:tw=0;42:ow=0;43:"
        export EDITOR='vim'
        export VISUAL='vim'
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
        export PATH=/usr/local/Cellar/emacs/HEAD/Emacs.app/Contents/MacOS/bin:$PATH
        export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.6/site-packages/:/Library/Python/2.5/site-packages:/usr/local/Cellar/python/2.6.2/lib/python2.6/site-packages:
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

# SVN ALIASES
gcco () {
    svn checkout http://$@.googlecode.com/svn/trunk/ $GOOGLE_CODE_CHECKOUTS/$@
}

## Functions
add_auth_key () {
    host=$1
    if  [ -z $host ] ; then
        echo "You must provide a host as the first (and only) argument"
        return
    fi
    if [ ! -f ~/.ssh/id_rsa.pub ] ; then
        command ssh-keygen -t rsa
    fi
    command scp ~/.ssh/id_rsa.pub $host:/tmp/tmp_rsa
    command ssh $host -t "if [ ! -d ~/.ssh ]; then mkdir ~/.ssh/;fi && cat /tmp/tmp_rsa >> ~/.ssh/authorized_keys && rm /tmp/tmp_rsa && chmod -R 700 ~/.ssh"
}


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

#tree () {
#    find $@ -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
#}

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


## PROMPT
# Prompt Colors
BRIGHT="\[`tput bold`\]"
DIM="\[`tput dim`\]"
GREEN="\[`tput setaf 2 sgr0`\]"
BGREEN="${BRIGHT}${GREEN}"
RED="\[`tput setaf 1 sgr0`\]"
BRED="${BRIGHT}${RED}"
BLUE="\[`tput setaf 4 sgr0`\]"
BBLUE="${BRIGHT}${BLUE}"
CYAN="\[`tput setaf 6 sgr0`\]"
DEFAULT="\[`tput sgr0`\]"
NORMAL="${DIM}${DEFAULT}"
# Prompt

PS1="${BRED}: ${NORMAL}\@${BRED}: ${BBLUE}[${NORMAL}\w${BBLUE}]${BGREEN} \$(parse_svn_rev)\$(parse_git_branch)${NORMAL}\u${BBLUE}@\H${BRED}; ${NORMAL}"
ORIG_PS1=$PS1

# Old Prompts 
# export PS1='\[\033[0;36m\]\d \[\033[00m\]- \[\033[1;37m\]\T \[\033[1;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: '
#export PS1='\[\033[0;36m\]\d \[\033[00m\]- \[\033[0;37m\]\T \[\033[1;37m\]\u\[\033[0;39m\]@\[\033[1;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: '

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

unegg () {
    unzip $1 -d tmp
    rm $1
    mv tmp $1
}



# Welcome Message
echo -e ""
echo -ne "Today is "; date
echo -e ""; cal;
echo -ne "Up time: ";uptime | awk /'up/ {print $3,$4}'
echo "";
fortune

