# bash-specific
eval "$(mcfly init bash)"
source ~/-/dotfiles/shell/.bash-completion
source ~/-/dotfiles/shell/.bash-debian-preload

# shared configs
source ~/-/dotfiles/shell/ssh
source ~/-/dotfiles/shell/.shellrc

# RANDOM STUFF --v

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/aguestuser/google-cloud-sdk/path.bash.inc' ]; then . '/home/aguestuser/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/aguestuser/google-cloud-sdk/completion.bash.inc' ]; then . '/home/aguestuser/google-cloud-sdk/completion.bash.inc'; fi
