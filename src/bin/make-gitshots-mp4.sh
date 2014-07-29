#!/bin/bash

mkdir -p ~/Screensavers/
ffmpeg -r 6 -pattern_type glob -i ~/Pictures/gitshots/\*.jpeg -c:v libx264 -r 30 -pix_fmt yuv420p ~/Screensavers/gitshots.mp4
