#!/usr/bin/env bash

KBD_IMG="$HOME/.config/img/keyboard.png"
KBD_FILE="$HOME/.kbd-switch"
true >> "$KBD_FILE"

setup_ergodox () {
  # Ergodox → toujours en bépo sans options
  for id in $(xinput list | grep -i "ergodox" | cut -d= -f2 | cut -f1); do
    setxkbmap fr "bepo" -device "$id" -option 2> /dev/null
    ERGODOX="true"
  done
}

setup_default () {
      setxkbmap fr 
}

main () {
  setup_default
  setup_ergodox
}

main
# EOF

