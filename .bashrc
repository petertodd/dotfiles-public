# If not running interactively, don't do anything
[ -z "$PS1" ] && return

alias pd=pushd
alias po=popd
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias acs='apt-cache search'
alias acw='apt-cache show'

alias xo='xdg-open'

alias gcp='git ci -m n ; git push'
alias gst='git status'
alias gaa='git annex add'
alias gag='git annex get'
alias gas='git annex sync'
alias ga2g='git annex copy -t glacier --not --in=glacier'

alias btc=~/src/bitcoin/bitcoin/src/bitcoin-cli
alias tbtc='~/src/bitcoin/bitcoin/src/bitcoin-cli -testnet'
alias rbtc='~/src/bitcoin/bitcoin/src/bitcoin-cli -regtest'
alias ltc=~/src/litecoin/litecoin/src/litecoind
alias tltc='~/src/litecoin/litecoin/src/litecoind -testnet'

export EDITOR="vim"

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[0;33m\]\u@\h\[\033[00m\]:\[\033[0;31m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases

# red/yellow based color scheme
export LS_COLORS='di=0;31:ex=0;33:ln=0;36'

alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Completion for agi/acw/acs aliases
#
# Modified version of the _apt_get function from /etc/bash_completions
_agi_acw_acs()
{
    local cur prev special i

    COMPREPLY=()
    cur=`_get_cword`
    prev=${COMP_WORDS[COMP_CWORD-1]}

    COMPREPLY=( $( apt-cache pkgnames $cur 2> /dev/null ) )
    return 0
} &&
complete -F _agi_acw_acs agi &&
complete -F _agi_acw_acs acw &&
complete -F _agi_acw_acs acs

# Completion for agr alias
#
# Modified version of the _apt_get function from /etc/bash_completions
_agr()
{
    local cur prev special i

    COMPREPLY=()
    cur=`_get_cword`
    prev=${COMP_WORDS[COMP_CWORD-1]}

    COMPREPLY=( $( _comp_dpkg_installed_packages $cur ) )
    return 0
} &&
complete -F _agr agr

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/bin"

# vi editing mode on
set -o vi

# press C-p to search backwards for partial fragment completes in all history
bind -m vi-insert "\C-p":dynamic-complete-history

if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
fi
