#!/bin/bash
wget -nv 'https://github.com/mpv-player/mpv/raw/master/player/lua/auto_profiles.lua' -O'auto_profiles.lua'
TOOLS='autoload autodeint'
for t in ${TOOLS}
do
	wget -nv "https://github.com/mpv-player/mpv/raw/master/TOOLS/lua/${t}.lua" -O"${t}.lua"
done
