# Load all other setup files
for file in ~/.{bash_prompt,aliases,exports,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Colors for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# Options for shell cd
## Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
## Correct spelling errors in arguments supplied to cd
shopt -s cdspell;
## Autocorrect on directory names to match a glob.
#shopt -s dirspell 2> /dev/null
## Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

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
