#!/bin/bash

WALLPAPER_DIR=$(pwd)
CHANGE_SECONDS=300

IMAGES=$(find "$WALLPAPER_DIR" -name "*.jpg" -o -name "*.jpeg" -o -name "*.png")
readarray -t IMAGE_ARRAY <<< "$IMAGES"

if [ ${IMAGE_ARRAY[@]} -eq 0 ]; then
    exit 1
fi

while true; do
    IMAGE_INDEX=$((RANDOM % ${#IMAGE_ARRAY[@]}))
    IMAGE_SELEC="${IMAGE_ARRAY[$IMAGE_INDEX]}"

    if [ -f "$IMAGE_SELEC" ]; then
        if [ "$(uname)" == "Linux" ]; then
            gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_SELEC"
            gsettings set org.gnome.desktop.background picture-options "zoom"
        elif [ "$(uname)" == "Darwin" ]; then
            osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$IMAGE_SELEC\""
        fi
    fi
    sleep "$CHANGE_SECONDS"
done