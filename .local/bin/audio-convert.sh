#!/bin/bash
IFS=$'\n'
declare -ra commonOpt=( "-map_metadata" 0 "-id3v2_version" 3)
declare -ra mp3out=( "-c:a" libmp3lame "-qscale:a" 0 -f mp3 )
declare -ra flacout=( "-c:a" flac "-sample_fmt" s16 "-compression_level" 9 -f flac )

function Print {
	for var in "$@"
	do
		echo "${var}"
	done
}

function Convert {
	local inFmt="$1"
	local inpath="${2%/}"
	local outFmt="$3"
	local outpath="${4%/}"
	local -i isCopyOther=${5:-1}
	echo "In dir:  $inpath"
	echo "out dir: $outpath"
		
	declare -i paranum=0

	for path in $(find "$inpath" -type f)
	do
		local rlpath=${path#${inpath}/}
		local name="$(basename $path)"
		local newdir="${outpath}/$(dirname $rlpath)"
		
		# make parent dir
		[[ ! -d "${newdir}" ]] && mkdir -p "${newdir}"

		if [ $isCopyOther -eq 1 ];then
			if [ "${name##*.}" != "$inFmt" ];then
				cp -uv "${path}" "${newdir}/${name}"
				continue
			fi
		fi

		local newname="${name%$inFmt}${outFmt}"
		local outopt="${outFmt}out[@]"
		local newfile="${newdir}/${newname}"


		[[ -f "${newfile}" ]] && continue

		if [ $paranum -eq 3 ];then
			wait -n
			paranum=$((paranum-1))
		fi
		echo "converting $name"

		#paralle
		(
		rm -f "${newfile}_ff"
		ffmpeg -loglevel warning -i "${path}" '-vn' '-c:v' 'copy' ${!outopt} ${commonOpt[@]} "${newfile}_ff" > /dev/null
		mv "${newfile}_ff" "${newfile}" && echo "${newname} -- ok"
		) &

		paranum=$((paranum+1))
	done
	# wait all paralle
	wait
}

Convert $1 "$2" $3 "$4"
