source ~/.config/zsh/env.sh
# Lines configured by zsh-newuser-install
HISTSIZE=5000
SAVEHIST=10000
HISTFILE=$XDG_STATE_HOME/zsh/history
ZDOTDIR=$XDG_CONFIG_HOME/zsh


setopt appendhistory nomatch
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space
# rm * silent
setopt rm_star_silent
bindkey -e

source $XDG_CONFIG_HOME/zsh/antigenrc

#autoload bashcompinit && bashcompinit
autoload -U promptinit run-help colors 
promptinit
colors
alias help=run-help
alias ls='ls --color=tty'

#completion
#export LSCOLORS="Gxfxcxdxbxegedabagacad"
[[ -z "$LS_COLORS" ]] && \
	(( $+commands[dircolors] )) && eval "$(dircolors -b)" 
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b' 
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

## shift tab revese list
bindkey '^[[Z' reverse-menu-complete

setopt completealiases
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
compdef noproxy=exec
compdef nvr=exec
# correct from completion
#setopt correctall

#style
#PROMPT="(%*) %{$fg_bold[green]%}%n@%m%{$reset_color%} %{$fg_bold[white]%}%c%{$fg_bold[green]%}%(!.#.$)%{$reset_color%} "


setopt PROMPT_SUBST
E=$'\x1b'
# reset on the second line to make it the same in tmux + ncurses 6.0
PS1="%{${E}[2m%}%h $ZSH_PS_HOST%(?..%{${E}[91m%}%?%{${E}[0m%} )%{${E}[2;32m%}%~\$_current_branch
%{${E}[0m%}%(!.%{${E}[0;31m%}###.%{${E}[94m%}>>>)%{${E}[0m%} "
# 次提示符：使用暗色
PS2="%{${E}[2m%}%_>%{${E}[0m%} "
# 右边的提示
RPS1="%(1j.%{${E}[93m%}%j .)%{${E}[m%}%T"
unset E

# refresh right prompt
setopt transient_rprompt

# End of lines added by compinstall
source $XDG_CONFIG_HOME/zsh/aliases
source ~/.profile
