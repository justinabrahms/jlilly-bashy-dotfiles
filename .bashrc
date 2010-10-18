export PATH=$HOME/bin:$PATH
export GDAL_DATA=/opt/local/share
export MANPATH=/opt/local/share/man:$MANPATH
export CLASSPATH=$HOME/src/jars/*
export CLOJURE_EXT=$HOME/.clojure
export P4CONFIG=$HOME/.p4config
export P4EDITOR=$EDITOR
export WORKON_HOME=$HOME/.virtualenvs

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31'
export EDITOR='emacsclient'

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

# Filesystem
alias ..='cd ..'            # Go up one directory
alias ...='cd ../..'        # Go up two directories
alias ....='cd ../../..'    # And for good measure
alias l='ls -lah'           # Long view, show hidden
alias la='ls -AF'           # Compact view, show hidden
alias ll='ls -lFh'          # Long view, no hidden
if [ -e /usr/bin/byobu ]; then
    alias screen='byobu'
fi

# Mac Helpers
alias show_hidden="defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder"
alias hide_hidden="defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder"

# Helpers
alias grep='grep --color=auto' # Always highlight grep search term
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited
alias df='df -h'            # Disk free, in gigabytes, not bytes
alias du='du -h -c'         # Calculate total disk usage for a folder
alias sgi='sudo gem install' # Install ruby stuff
alias clj='clj-env-dir'        # Clojure helper
alias tt='tt++ $HOME/.ttconf'

# Nifty extras
alias irc="ssh justinlilly.com"
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"
alias clr='clear;echo "Currently logged in on $(tty), as $(whoami) in directory $(pwd)."'
alias pypath='python -c "import sys; print sys.path" | tr "," "\n" | grep -v "egg"'
alias pycclean='find . -name "*.pyc" -exec rm {} \;'
alias ssh='ssh -R 10999:localhost:22'

# GIT ALIASES
alias git='hub'
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
alias gr='git stash && git svn rebase && git svn dcommit && git stash pop' # git refresh
alias gd='git diff | $GIT_EDITOR -'
alias gmv='git mv'
alias gho='$(git remote -v 2> /dev/null | grep github | sed -e "s/.*git\:\/\/\([a-z]\.\)*/\1/" -e "s/\.git$//g" -e "s/.*@\(.*\)$/\1/g" | tr ":" "/" | tr -d "\011" | sed -e "s/^/open http:\/\//g")'

# HG ALIASES
alias hgst='hg status'
alias hgd='hg diff | $GIT_EDITOR -'

# -- start rip config -- #
export RUBYLIB="$RUBYLIB:$HOME/src/rip/lib/"
export PATH="$PATH:$HOME/src/rip/bin/"
if [ `which rip-config` ]; then
    eval `rip-config`
fi
# -- end rip config -- #


# == STOP IF NON INTERACTIVE ==
[ -z "$PS1" ] && return

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
        export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.5/site-packages/:
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

if [ -z `which tree` ]; then
  tree () {
      find $@ -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
  }
fi

mcd () {
    mkdir "$@" && cd "$@"
}

exip () {
    # gather external ip address
    echo -n "Current External IP: "
    curl -s -m 5 http://myip.dk | grep "<title>" | sed -e 's/<title>Your IP address is: //g' -e 's/<\/title>//g'
}

pastie() {
        url=$(curl http://pastie.caboo.se/pastes/create \
                -H "Expect:"                                \
                -F "paste[parser]=$PASTIE_LANG"             \
                -F "paste[body]=<-"                         \
                -F "paste[authorization]=burger"            \
                -s -L -o /dev/null -w "%{url_effective}" )
        echo "$url" | xclip
	echo "$url"
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

get_rip_env(){
    rip-env
}


## PROMPT
# Prompt Colors
RED="\[\033[0;31m\]"
PINK="\[\033[1;31m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[0;32m\]"
LT_GREEN="\[\033[1;32m\]"
BLUE="\[\033[0;34m\]"
WHITE="\[\033[1;37m\]"
PURPLE="\[\033[1;35m\]"
CYAN="\[\033[1;36m\]"
BROWN="\[\033[0;33m\]"
COLOR_NONE="\[\033[0m\]"

LIGHTNING_BOLT="⚡"
UP_ARROW="↑"
DOWN_ARROW="↓"
UD_ARROW="↕"
FF_ARROW="→"
RECYCLE="♺"
MIDDOT="•"
PLUSMINUS="±"

function parse_git_branch {
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern_ahead="# Your branch is ahead of"
  remote_pattern_behind="# Your branch is behind"
  remote_pattern_ff="# Your branch (.*) can be fast-forwarded."
  diverge_pattern="# Your branch and (.*) have diverged"

  git_status="$(git status 2> /dev/null)"
  if [[ ! ${git_status} =~ ${branch_pattern} ]]; then
    # Rebasing?
    toplevel=$(git rev-parse --show-toplevel 2> /dev/null)
    [[ -z "$toplevel" ]] && return

    [[ -d "$toplevel/.git/rebase-merge" || -d "$toplevel/.git/rebase-apply" ]] && {
      sha_file="$toplevel/.git/rebase-merge/stopped-sha"
      [[ -e "$sha_file" ]] && {
        sha=`cat ${sha_file}`
      }
      echo "${PINK}(rebase in progress)${COLOR_NONE} ${sha}"
    }
    return
  fi

  branch=${BASH_REMATCH[1]}

  # Dirty?
  if [[ ! ${git_status} =~ "working directory clean" ]]; then
    [[ ${git_status} =~ "modified:" ]] && {
      git_is_dirty="${RED}${LIGHTNING_BOLT}"
    }

    [[ ${git_status} =~ "Untracked files" ]] && {
      git_is_dirty="${git_is_dirty}${WHITE}${MIDDOT}"
    }

    [[ ${git_status} =~ "new file:" ]] && {
      git_is_dirty="${git_is_dirty}${LT_GREEN}+"
    }

    [[ ${git_status} =~ "deleted:" ]] && {
      git_is_dirty="${git_is_dirty}${RED}-"
    }

    [[ ${git_status} =~ "renamed:" ]] && {
      git_is_dirty="${git_is_dirty}${YELLOW}→"
    }
  fi

  # Are we ahead of, beind, or diverged from the remote?
  if [[ ${git_status} =~ ${remote_pattern_ahead} ]]; then
    remote="${YELLOW}${UP_ARROW}"
  elif [[ ${git_status} =~ ${remote_pattern_ff} ]]; then
    remote_ff="${WHITE}${FF_ARROW}"
  elif [[ ${git_status} =~ ${remote_pattern_behind} ]]; then
    remote="${YELLOW}${DOWN_ARROW}"
  elif [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}${UD_ARROW}"
  fi

  echo "${remote}${remote_ff}${GREEN}(${branch})${COLOR_NONE}${git_is_dirty}${COLOR_NONE}"
}

function set_prompt {
  [[ -n $HOMEBREW_DEBUG_INSTALL ]] && \
    homebrew_prompt="${BROWN}Homebrew:${COLOR_NONE} debugging ${HOMEBREW_DEBUG_INSTALL}\n"

  git_prompt="$(parse_git_branch)"
  if [ ! -z $VIRTUAL_ENV ]; then
    venv_name="<${CYAN}venv:${VIRTUAL_ENV##*/}${COLOR_NONE}> " # last folder's name in a directory path
  else
    venv_name=""
  fi

  export PS1="${venv_name}[\w] ${git_prompt}${COLOR_NONE}\n${homebrew_prompt}\$ "
}
export PROMPT_COMMAND=set_prompt

# Prompt
# PS1='\[\033[0;36m\]\d \[\033[00m\]- \[\033[1;37m\]\T \[\033[1;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: '
# PS1='\[\033[0;36m\]\d \[\033[00m\]- \[\033[0;37m\]\T \[\033[1;37m\]\u\[\033[0;39m\]@\[\033[1;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: '
# PS1="${GREEN}rip:\$(get_rip_env) ${BRED}:${NORMAL}\@${BRED}: ${BBLUE}[${NORMAL}\w${BBLUE}]${BGREEN} \$(parse_svn_rev)\$(parse_git_branch)${NORMAL}\u${BBLUE}@\H${BRED}; ${NORMAL}"



if [ $TERM == "eterm-color" ]; then
  # prompt for emacs (width sensitive)
  PS1='\u@\h:\w\$ '
fi

ORIG_PS1=$PS1

source $HOME/bin/virtualenvwrapper.sh

has_virtualenv() {
    if [ -e .venv ]; then
        CURRENT_VENV=$WORKON_HOME/`cat .venv`
        if [ "$CURRENT_VENV" != "$VIRTUAL_ENV" ]; then
            workon `cat .venv`
        fi
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

if [ -z `pidof emacs` ]; then
  # If emacs isn't running, start it in daemon mode.
  echo -n "Starting emacs..."
  emacs --daemon 2>/dev/null
  echo "Done."
fi


# Run on new shell
if [ `which fortune` ]; then
    echo ""
    fortune
    echo ""
fi

