#!/bin/bash

root="/home"; outp="./test"; pos="$root"

umount "$outp"

[[ -n $1 ]] && device="$@" || exit

while :; do
        echo " - $pos"

        if ! ssh "$device" ls "$pos"; then
          pos="$posOld"
          continue
        fi

        read -p "Where now? " move

        [[ -z "$move" ]] && break

        posOld="$pos"; pos+="/$move"
done

pos="${pos//\"/}"

echo " LINKING $pos TO $outp "
sshfs "$device:$pos" "$outp"
