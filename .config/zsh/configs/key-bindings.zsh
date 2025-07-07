# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
key[Esc]='^['

bindkey -r "${key[Esc]}"    # [Esc] (Default: vi-cmd-mode)

bindkey '^Z' undo
bindkey '^Y' redo
bindkey '^Q' push-line
bindkey ' '  magic-space  # [Space] Do history expansion

# Widgets are from zsh-history-substring-search
bindkey "${key[Up]}"   history-substring-search-up
bindkey "${key[Down]}" history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
