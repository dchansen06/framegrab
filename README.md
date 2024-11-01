[![Check](https://github.com/dchansen06/framegrab/actions/workflows/check.yml/badge.svg)](https://github.com/dchansen06/framegrab/actions/workflows/check.yml)
# framegrab
A short program to take an input video, and then spit out every set amount of frames

## Usage
Install [ffmpeg(1)](https://linux.die.net/man/1/ffmpeg) if you do not have it already.

Set the video filename(s) to be the arguments, as many as needed.

Set current directory to be the location where the frames should be. I highly reccomend you make sure it is empty so that you can remove the whole directory later.

Options include jpeg (default), png, gif, tiff, webp, ppm, and bmp, specify by setting the first argument to the desired format (ie --tiff / --tif / -t)

## Disclaimer
Use at your own risk, an improper video or other issue may not have the indended result. Be careful not to overwrite your files.

## Usage
```$ chmod a+x framegrab.sh```

```$ cd TO_A_EMPTY_DIRECTORY_PREFERABLY```

```$ ./framegrab.sh --png /path/to/video.mp4```
