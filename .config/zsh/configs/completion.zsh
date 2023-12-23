zmodload zsh/complist
autoload -Uz compinit; compinit

[[ -z "$LS_COLORS" ]] && (( $+commands[dircolors] )) && eval "$(dircolors -b)" 
setopt completealiases
#setopt correctall

# misc
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~cache/zsh/.zcompcache
zstyle ':completion:*' squeeze-slashes true

# file
zstyle ':completion:*' file-sort modification 

# format
zstyle ':completion:*:descriptions' format '%U%B-- %d --%b%u'
zstyle ':completion:*:corrections' format '%B!- %d (errors: %e) -!%b'
zstyle ':completion:*:warnings' format '%B! Sorry, no matches for: %d !%b' 
zstyle ':completion:*:messages' format ' %B-- %d --%b'

# match
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# key
bindkey '^[[Z' reverse-menu-complete # tab
