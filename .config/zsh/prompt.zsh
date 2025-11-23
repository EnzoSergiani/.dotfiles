autoload -Uz colors && colors

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ":vcs_info:git:*" formats "%b"

PROMPT='%F{cyan}[%n@%m]%f %F{yellow}[%~]%f %F{magenta}[${vcs_info_msg_0_}]%f
❯ '

