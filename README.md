# Description
This directory contains all dotfiles to be used in linux shell. 

# Usage
All files should be downloaded in one directory and `makeLinks.sh` script should be used to create symbolic links to them in home directory.
When new files are added, the script should be rerun to create new links

# File content
- `.ssh/config` SSH config file ([usage example](https://linuxize.com/post/using-the-ssh-config-file/))
- `.aliases` shell aliases
- `.bash_logout` actions to be performed on logout
- `.bash_profile` loads all bash setup files and does basic bash configuration
- `.bash_prompt` prompt configuration (colors, git dirtiness)
- `.bashrc` old configuration **probably should be deleted**
- `.functions` shell functions
- `.gitconfig` git confgituraion
- `.hushlogin` empty file, hides login message
