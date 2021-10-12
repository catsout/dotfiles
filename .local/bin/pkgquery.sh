#!/bin/bash
CURL="curl -sL"
ELINKS="elinks -dump -dump-color-mode 1 --no-references -no-numbering --no-home"

function get_pkg_ver {
	local _arch=$1
	local _name=$2
	local url="https://qa.debian.org/madison.php?"
	local pkg="package=$_name"
	local arch=""
	[ "$_arch" != "any" ] && arch="&a=$_arch"
	local other="table=all&text=on"
	$CURL "$url$pkg$arch&$other#" | grep -v ubuntu
}

function search_pkg {
	function is_on_name {
		[ "$1" == "name" ]
	}
	local _mode=$1
	local _arch=$2
	local _name=$3
	local div_id=`is_on_name $_mode && echo psearchres || echo pcontentsres`
	local XML="xmllint --nowarning --noblanks --html --xpath '//div[@id=\"$div_id\"]' -"
	local url="https://packages.debian.org/search?"
	#mode= name,path,filename
	local keywords="keywords=$_name"
	local mode=`is_on_name $_mode && echo "searchon=names" || echo "searchon=contents&mode=$_mode"`
	local other="suite=unstable&arch=$_arch"
	$CURL "$url$mode&$keywords&$other#" | eval $XML | $ELINKS
}

function show_help {
	echo "$0  [OPTION]...  NAME" 
	echo "Default query the version info of package with NAME"
	echo ""
	echo "-s <search mode> name,path,filename" 
	echo "-a <arch>        any,amd64,..." 
	echo ""
	return 0
}

function main {
	local argc=$#
	local search=0
	local s_mode="name"
	local arch="any"
	local OPTERR=1
	local OPTIND=1
	while getopts "h?s:a:" opt; do
	  case "$opt" in
		h|\?)
		  show_help "$0"
		  exit 0
		  ;;
		s)
		  search=1
		  s_mode="$OPTARG"
		  ;;
		a)
		  arch="$OPTARG"
		  ;;
	  esac
	done
	shift $((OPTIND-1))
	[ $# -gt 0 ] || { show_help "$0" && exit 1; }
	if [ $search -eq 1 ];then
		search_pkg $s_mode $arch $1
	else
		get_pkg_ver $arch $1
	fi
}

main "$@"
