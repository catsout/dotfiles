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
	local func="$2"
	local code="$3"
	shift 3

	for path in $(find "$dir" -type f "$@")
	do
		$func $code "$path"
	done
}


declare -r tmp="$(mktemp)"
function metaIconv {
	local from_code="$1"
	local file="$2"
	metaflac --no-utf8-convert --export-tags-to=- "$file" | iconv -f $from_code > "$tmp"
	[ $? -eq 0 ] || return
	metaflac --no-utf8-convert --remove-all-tags --import-tags-from="$tmp" "$file"
}

WorkDir "$1" metaIconv "$2" -iname "*.flac"
