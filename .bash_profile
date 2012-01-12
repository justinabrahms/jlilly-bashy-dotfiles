if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


# Source local additions
if [ -f ~/.bash_local ]; then
	. ~/.bash_local
fi
export CLOJURESCRIPT_HOME=/home/justinlilly/src/clojurescript
export PATH=/home/justinlilly/src/clojurescript/bin:/home/justinlilly/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl
