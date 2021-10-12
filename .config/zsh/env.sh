#export GST_VAAPI_ALL_DRIVERS=1
#export QT_XCB_GL_INTEGRATION=xcb_glx
#XDG

# export xdg, if not defined
if [ ! $XDG_CONFIG_HOME ]; then
	export XDG_CACHE_HOME=$HOME/.cache
	export XDG_CONFIG_HOME=$HOME/.config
	export XDG_DATA_HOME=$HOME/.local/share
	export XDG_STATE_HOME=$HOME/.local/state
fi

#vscode
export VSCODE_PORTABLE=$XDG_DATA_HOME/vscode

MY_CACHE_HOME=$HOME/.cache
MY_CONFIG_HOME=$HOME/.config
MY_DATA_HOME=$HOME/.local/share
MY_STATE_HOME=$HOME/.local/state

#
export PATH=$PATH:$HOME/.local/bin 
export SSH_KEY_PATH=~/.ssh/rsa_id
export DEFAULT_USER=`whoami`
export EDITOR=vi
export VIMINIT="source $MY_CONFIG_HOME/vim/vimrc"
export PASSWORD_STORE_DIR=$MY_CONFIG_HOME/password-store

#wget
export WGETRC=$MY_CONFIG_HOME/wgetrc

#bash
export BASH_COMPLETION_USER_FILE=$MY_CONFIG_HOME/bash-completion/bash_completion

#java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=$MY_CONFIG_HOME/java
#npm
export NPM_CONFIG_USERCONFIG=$MY_CONFIG_HOME/npm/npmrc
#docker
export DOCKER_CONFIG=$MY_CONFIG_HOME/docker
export MACHINE_STORAGE_PATH=$MY_DATA_HOME/docker-machine

#DXVK
export DXVK_STATE_CACHE_PATH=/home/out/Sync/.cache/dxvk
#export DXVK_CONFIG_FILE=/home/out/.config/dxvk/dxvk.conf
export DXVK_LOG_PATH=/home/out/Sync/.cache/dxvk
export DXVK_HUD=fps
export DXVK_FILTER_DEVICE_NAME=Intel

#ANDORID
export ANDROID_HOME=$MY_DATA_HOME/Android/Sdk
export NDK=$ANDROID_HOME/ndk-bundle
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools
#Flutter
export PATH=$PATH:/opt/flutter/bin
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PUB_HOSTED_URL=https://pub.flutter-io.cn

#Gtk
export GTK_RC_FILES=$MY_CONFIG_HOME/gtk-1.0/gtkrc
export GTK2_RC_FILES=$MY_CONFIG_HOME/gtk-2.0/gtkrc

#Cargo
export CARGO_HOME=$MY_DATA_HOME/cargo
export RUSTUP_HOME=$MY_DATA_HOME/rustup
export PATH=$PATH:$CARGO_HOME/bin

#Go
export GOPATH=$MY_DATA_HOME/go
#conan
export CONAN_USER_HOME=$MY_CONFIG_HOME/conan
#Gradle
export GRADLE_USER_HOME=$MY_DATA_HOME/gradle
#FFmpeg
export FFMPEG_DATADIR=$MY_CONFIG_HOME/ffmpeg

export MCHRDIR=/opt/chroot
export PATH=$PATH:/usr/lib/dart/bin

export WINEPREFIX=$HOME/.local/share/wine
