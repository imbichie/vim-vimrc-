# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
GROUPID=`id -gn`
#export PS1="\[\e[1;35m\]\h \[\e[1;34m\]\$GROUPID \[\e[1;31m\]\u \[\e[1;32m\]\w \[\e[1;32m\]\n\[\e[1;33m\] $ \[\e[m\]"
#export PS1="\[\e[1;35m\]\h \[\e[1;31m\]\u \[\e[1;32m\]\w \[\e[1;32m\]\n\[\e[1;33m\] $ \[\e[m\]"
export PS1="\[\e[1;35m\]\h \[\e[1;31m\]\u \[\e[1;32m\]\w \[\e[1;32m\]\n\[\e[1;33m\]$ "

#PROMPT_COMMAND='echo -en "\033]0;`pwd | rev | cut -d/ -f1-2 | rev `\a"'
PROMPT_COMMAND='echo -en "\033]0;`pwd | rev | cut -d/ -f1,2,3,4 | rev `\a"'

export autolist ambigous
export complete enhance

export filec
export ignoreeof
export notify
export HISTSIZE=100000
export savehist=100000
export HISTCONTROL=erasedups:ignoredups
export HISTIGNORE="ls:ps:history"

## which shell
    alias wshell="ps -p $$"
## create parent dirctories on demand
    alias mkdir='mkdir -pv'
## clear screen
    alias c=clear
## gvim editor
    alias g=gvim
    alias gv=gview
    alias gp='gvim -p'
    alias go='gvim -o'
    alias gO='gvim -O'
    alias gd='gvim -geometry +0+0 -d'
    alias gn='gvim -u NONE'
## folder compare in gui mode
    alias com=kompare
    alias td=tkdiff
    alias md=meld
## remove with permission
    alias rm="rm -i"
## copy with permission
    alias cp="cp -i"
## move with permission
    alias mv="mv -i"
## display the content with color
    alias ls="ls --color=always"
## show hidden files
    alias l.='ls -d .*'
    alias ll="ls -altr"
    alias lsa="ls -a"
## listout hte files with size
    alias lss="ls -c -lh"
## listout the files with modified time
    alias lst="ls -c -alt"
## listout the files with type
    alias lx="ls -c -X"
## create filelist
    alias cfl="find -follow"
## highlight and ignore case with the grep word
    alias grep="grep -i --color=auto"
## find the file using find command, usage : $ ff "*name*"
    alias ff='find . -type f -name'
## find the dirctory using find command, usage : $ fd "*name*"
    alias fd='find . -type d -name'
## disc space in current dirctory
    alias space="du -hs * | sort"
## total disc space in the current dirctory
    alias space_t="du -csh"
## total disc space in the specified user, usage : $ disc_t "shibinbose"
    alias disc_t="df -h | grep"
## total number of files in the dirctory
    alias nof="lx ./ | wc -l"
## total number of lines in sv files
    alias nol="find . -name '*.sv' | xargs c -l"
## task finished pop-ups
    alias zi="zenity --info --text='Job Finished'"
## list the .nfs jobs running
    alias njobs="lsof +D ."
## correct screen resolution
    alias csr="xrandr --output VNC-0 --dpi 120"

## git
    alias gits="git status"
    alias gitl="git log"
    alias gitb="git branch"
    alias gitd="git diff"
    alias gitdh="git diff HEAD^ --"
