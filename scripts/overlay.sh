#!/bin/sh

set -e

OVERLAYS=/sys/kernel/config/device-tree/overlays

add()
{
    if [ ! -e "$1" ]; then
        echo "Overlay not found: $1"
        exit 1
    fi

    if [ ! "${1##*.}" = "dtbo" ]; then
        echo "Invalid overlay: $1"
        exit 1
    fi

    name=$(basename "$1" .dtbo)

    if [ -e "$OVERLAYS/$name" ]; then
        echo "Overlay already exists: $name"
        exit 1
    fi

    mkdir "$OVERLAYS/$name"
    cat "$1" > "$OVERLAYS/$name/dtbo"
}

remove()
{
    rmdir "$OVERLAYS/$1"
}

cmd=add

for i in "$@"; do
    case $i in
        add)
            cmd=add
            ;;
        rm)
            cmd=remove
            ;;
        *)
            $cmd "$i"
            ;;
    esac
done
