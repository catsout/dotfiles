alias poffdisk='udisksctl power-off -b'
alias dusize='du -h --total --one-file-system --max-depth=1 | sort -h'
alias getjdk8='PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin:$PATH'
alias passpush='pass git push origin master'
alias passpull='pass git pull origin master'
alias sedxargs='echo {}|sed'
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
alias iconv_gbk="iconv -f gbk -t utf-8"
alias nmpv='nvr mpv --hwdec=vaapi-copy --vo=gpu'
alias youdl-url='youtube-dl --get-url --get-filename'
alias glxrun='QT_XCB_GL_INTEGRATION=xcb_glx'
alias cmakeb='cd build && cmake .. && cd ..'
alias frun='flatpak run'
alias vi='nvim'
alias vim='nvim'
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias stow='stow -v'
alias nvidia-settings="nvidia-settings --config=$XDG_CONFIG_HOME/nvidia/settings"
alias hiostat='iostat -N --human --pretty'
alias yadm-ls='yadm ls-tree --name-only master'
alias external-data-checker='flatpak run --filesystem=`pwd` org.flathub.flatpak-external-data-checker'
[ -f /usr/bin/mpv ] || alias mpv='flatpak run io.mpv.Mpv'
alias pyenv='python3 -m venv --system-site-packages --upgrade --upgrade-deps'
alias git_wip='GIT_SSH_COMMAND="ssh -i $HOME/.ssh/id_rsa.wip -o IdentitiesOnly=yes" git'
alias ip='ip -c'
