# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

addMochaColorsToTTY() {
				printf %b '\e]P0 #1E1E2E' # set background color to "Base" #1E1E2E
				printf %b '\e]P8 #585B70' # set bright black to "Surface2" #585B70
				printf %b '\e]P7 #BAC2DE' # set text color to "Text" #BAC2DE
				printf %b '\e]PF #A6ADC8' # set bright white to "Subtext0" #A6ADC8
				printf %b '\e]P1 #F38BA8' # set red to "Red" #F38BA8
				printf %b '\e]P9 #F38BA8' # set bright red to "Red" #F38BA8
				printf %b '\e]P2 #A6E3A1' # set green to "Green" #A6E3A1
				printf %b '\e]PA #A6E3A1' # set bright green to "Green" #A6E3A1
				printf %b '\e]P3 #F9E2AF' # set yellow to "Yellow" #F9E2AF
				printf %b '\e]PB #F9E2AF' # set bright yellow to "Yellow" #F9E2AF
				printf %b '\e]P4 #89B4FA' # set blue to "Blue" #89B4FA
				printf %b '\e]PC #89B4FA' # set bright blue to "Blue" #89B4FA
				printf %b '\e]P5 #F5C2E7' # set magenta to "Pink" #F5C2E7
				printf %b '\e]PD #F5C2E7' # set bright magenta to "Pink" #F5C2E7
				printf %b '\e]P6 #94E2D5' # set cyan to "Teal" #94E2D5
				printf %b '\e]PE #94E2D5' # set bright cyan to "Teal" #94E2D5
				#clear
}

addMochaColorsToTTY

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
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

# this the prompt i want but the above stuff basically do the same but better
# export PS1"\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# source environment variables and other secrets
[[ -f ~/.bashenvs ]] && . ~/.bashenvs

# source configs specific to this pc
if [ -f ~/.bash_thispc ]; then
    . ~/.bash_thispc
fi

# source configs for all pcs
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# system functions
if [ -f ~/.local/bin/sys/systtemsetings ]; then
    . ~/.local/bin/sys/systemsettings
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#for auto cd'ing without typing 'cd'
#shopt -s autocd

