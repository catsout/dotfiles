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
setopt no_share_history
HISTFILE=~state/zsh/history

# rm * silent
setopt rm_star_silent
bindkey -e

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r ~cache/p10k-instant-prompt-${(%):-%n}.zsh ]]; then
  source ~cache/p10k-instant-prompt-${(%):-%n}.zsh
fi

# autoload
autoload -Uz promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz run-help

alias help=run-help
alias ls='ls --color=tty'

source ~zdot/configs/completion.zsh
source ~zdot/configs/plugin.zsh
source ~zdot/configs/aliases.zsh
source ~zdot/configs/key-bindings.zsh
source ~/.profile

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
