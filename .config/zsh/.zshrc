hash -d zdot=$ZDOTDIR

source ~zdot/env/env.zsh

hash -d config=$XDG_CONFIG_HOME
hash -d cache=$XDG_CACHE_HOME
hash -d data=$XDG_DATA_HOME
hash -d xdg_state=$XDG_STATE_HOME

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
HISTFILE=~xdg_state/zsh/history
setopt appendhistory nomatch
setopt no_share_history
setopt hist_ignore_dups
setopt hist_find_no_dups

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
#        . "/usr/etc/profile.d/conda.sh"
#    else
#        export PATH="/usr/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


