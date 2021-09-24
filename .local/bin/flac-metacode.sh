#!/bin/bash
IFS=$'\n'

function Print {
	for var in "$@"
	do
		echo "${var}"
	done
}

function WorkDir {
	local dir="$1"
	local f="$2"
	shift 2

	for path in $(find "$dir" -type f "$@")
	do
		$f "$path"
	done
}


declare -r tmp="$(mktemp)"
function metaIconv {
	local file="$1"
	metaflac --no-utf8-convert --export-tags-to=- "$file"|iconv -f gbk -t utf-8 > "$tmp"
	[ $? -eq 0 ] || return
	metaflac --no-utf8-convert --remove-all-tags --import-tags-from="$tmp" "$file"
}

WorkDir "$1" metaIconv -iname "*.flac"
