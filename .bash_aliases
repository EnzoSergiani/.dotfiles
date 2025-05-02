# -----------------------
# Alias Definitions
# -----------------------

# ls and grep
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias tp='cd "$OLDPWD"'

# File operations
cd() { builtin cd "$@" && ls; }
alias mv='mv -i'
alias cp='cp -i'
alias rm='trash-put'
alias mkdir='mkdir -p'
alias cat="bat"
# Package management
alias update='sudo dnf update -y && sudo dnf upgrade -y'
# alias install='fzf_install'
# alias remove='fzf_remove'
# alias list='fzf_list'

# Developer shortcuts
alias python='python3'

# Typos
alias :q='exit'
alias help='man'
alias quit='exit'
