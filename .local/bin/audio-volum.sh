#!/bin/bash

ffmpeg -hide_banner -i "$1" -af volumedetect,silencedetect,ebur128=framelog=verbose -f null /dev/null 
