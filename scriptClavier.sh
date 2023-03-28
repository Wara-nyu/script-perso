#!/usr/bin/env bash

setup_ergodox () {
  for id in $(xinput list | grep -i "ergodox" | cut -d= -f2 | cut -f1); do
    setxkbmap fr "bepo" -device "$id" -option 2> /dev/null
    ERGODOX="true"
  done
}

setup_default () {
      setxkbmap fr -option
}

main () {
  setup_default
  setup_ergodox
}

main
# EOF

