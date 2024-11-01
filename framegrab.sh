#!/bin/bash

start=$(date +%s%3N)

HELP=("help" "h" "info" "?" "--help" "-h" "--info" "-?")

if [[ "${HELP[@]}" =~ $1 ]]
then
	echo "Set the video filename(s) to be the arguments, as many as needed"
	echo "Set current directory to be the location where the frames should be"
	echo "Options include jpeg (default), png, gif, tiff, webp, ppm, bmp"
	echo "Specify by setting the first argument to the desired format (ie --tiff / --tif / -t)"
	echo
	echo "Supported options include"
	echo "Display help	--help"
	echo "Use jpeg		--jpeg, --jpg, -j"
	echo "Use png		--png, -p"
	echo "Use gif		--gif, -g"
	echo "Use tiff		--tiff, -t"
	echo "Use webp		--webp, --web, -w"
	echo "Use ppm		--ppm, -m"
	echo "Use bmp		--bmp, -b"
	exit 0
fi

JPEG=("jpeg" "jpg" "j" "--jpeg" "--jpg" "-j")
PNG=("png" "p" "--png" "-p")
GIF=("gif" "g" "--gif" "-g")
TIFF=("tiff" "tif" "t" "--tiff" "--tif" "-t")
WEBP=("webp" "web" "w" "--webp" "--web" "-w")
PPM=("ppm" "p" "--ppm" "-m")
BMP=("bmp" "b" "--bmp" "-b")

if [[ "${JPEG[@]}" =~ "$1" ]]; then shift; format="jpg"
elif [[ "${PNG[@]}" =~ "$1" ]]; then shift; format="png"
elif [[ "${GIF[@]}" =~ "$1" ]]; then shift; format="gif"
elif [[ "${TIFF[@]}" =~ "$1" ]]; then shift; format="tiff"
elif [[ "${WEBP[@]}" =~ "$1" ]]; then shift; format="webp"
elif [[ "${PPM[@]}" =~ "$1" ]]; then shift; format="ppm"
elif [[ "${BMP[@]}" =~ "$1" ]]; then shift; format="bmp"
else echo "No known format selected"; format="jpg"
fi

echo "Using $format"

divide() {
	echo "Grabbing frames from $(basename $1)"
	ffmpeg -r 1 -i "$1" -r 1 "$(basename $1)%07d.$2"
}

for file in $@
do
	if [[ $(file -i "$file") =~ "video" ]]
	then
		divide "$file" "$format"
	else
		echo -n "Error! File $file does not exist or is not a video, attempt to open file (yes/no/quit)? "

		NO=("NO" "No" "no" "N" "n")
		YES=("YES" "Yes" "yes" "Y" "y")
		read response

		if [[ "${NO[@]}" =~ "$response" ]]
		then
			echo "Skipping $file"
		elif [[ "${YES[@]}" =~ "$response" ]]
		then
			echo "Reading $file regardless"
			divide "$file" "$format"
			echo "Press enter to continue"
			read
		else
			echo "Exiting"
			exit 1
		fi
	fi
done

end=$(date +%s%3N)

echo "It took $((end-start))ms or ~$((end/1000-start/1000))s to grab the frames"
