# hash shortcut
hash -d zdot=$ZDOTDIR
hash -d config=$XDG_CONFIG_HOME
hash -d cache=$XDG_CACHE_HOME
hash -d data=$XDG_DATA_HOME
hash -d state=$XDG_STATE_HOME

# fpath, completions, functions
fpath=(
    ~zdot/completions
    ~zdot/functions
    $fpath
)
# lazy load functions
#autoload -Uz ~zdot/functions/*(:t)

# misc
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# hist
setopt appendhistory nomatch
setopt share_history
HISTFILE=~state/zsh/history

# rm * silent
setopt rm_star_silent
bindkey -e

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "~cache/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "~cache/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit 
compinit
#bashcompinit

# plugin
source ~zdot/zgenom/zgen.zsh
if ! zgenom saved; then
    echo "Creating a zgenom save"
	zgenom load zsh-users/zsh-autosuggestions
	zgenom load zsh-users/zsh-history-substring-search
	zgenom load zsh-users/zsh-completions

	zgenom load romkatv/powerlevel10k powerlevel10k
	zgenom load zdharma-continuum/fast-syntax-highlighting
    zgenom load 3v1n0/zsh-bash-completions-fallback

	zgenom ohmyzsh lib/clipboard.zsh
	zgenom ohmyzsh lib/history.zsh
	zgenom ohmyzsh plugins/extract
	zgenom ohmyzsh plugins/cp
    zgenom ohmyzsh plugins/z

	zgenom save
fi

autoload -U promptinit run-help colors 
promptinit
colors
alias help=run-help
alias ls='ls --color=tty'

# ------ completion -------
setopt completealiases
#setopt correctall

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

# refresh right prompt
# setopt transient_rprompt

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
ZSH_AUTOSUGGEST_MANUAL_REBIND='1'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=6,bold,underline"

source ~zdot/configs/aliases.zsh
source ~zdot/configs/key-bindings.zsh
source ~/.profile

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
