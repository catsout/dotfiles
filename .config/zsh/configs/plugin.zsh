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

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
ZSH_AUTOSUGGEST_MANUAL_REBIND='1'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=6,bold,underline"
