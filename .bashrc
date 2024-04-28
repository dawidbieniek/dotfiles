# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Append to the history file, don't overwrite it
shopt -s histappend
# Set colors for ls

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    alias grep='grep --color=auto'
else
    alias ls='ls --group-directories-first'
fi

# Set colors of prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[01;32m\]@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# git commands
if git --version 2>&1 >/dev/null; then
	gic()
	{
	  git add .
	  git commit -m "$1"
	}

	gat()
	{
	  git checkout --theirs "$1"
	  git add "$1"
	}

	gao()
	{
	  git checkout --ours "$1"
	  git add "$1"
	}
fi

# Simple aliases
alias ll='ls -alF'
alias la='ls -AF'
alias cls='clear'
alias cd..='cd ..'

# WSL aliases
if [ -e /proc/sys/fs/binfmt_misc/WSLInterop ]; then
	alias e='explorer.exe .'
fi

### TMP ###
export PATH="$HOME/.local/bin:$PATH"
