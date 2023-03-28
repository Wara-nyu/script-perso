#!/usr/bin/env bash
BEPO_VERSION="bepo_afnor"

KBD_IMG="$HOME/.config/img/keyboard.png"
#image pour le popup de notif
KBD_FILE="$HOME/.kbd-switch"
#fichier où est écrit la confiration actuelle du clavier (fr par exemple, juste ça) pour la notif
true >> "$KBD_FILE"
#écrit dans le fichier ?
LAYOUT=$(head -1 "$KBD_FILE")

 #pour notifier le changement de layout
notif-change-layout () {
  LAYOUT_NAME=$1
  NEW_LAYOUT=$(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}')
  echo "$CURRENT_LAYOUT → $NEW_LAYOUT ($LAYOUT_NAME)"
  notify-send "$LAYOUT_NAME" --expire-time=1000 --icon="$KBD_IMG" --category="Layout"
}

setup_typematrix () {
  # TypeMatrix → toujours en bépo sans options
  for id in $(xinput list | grep -i "typematrix" | cut -d= -f2 | cut -f1); do
    setxkbmap fr $BEPO_VERSION -device "$id" -option 2> /dev/null
    TYPEMATRIX="true"
  done
  if [ -n "$TYPEMATRIX" ] && [ ! "BÉPO" == "$NOTIF" ];
  then
    NOTIF="TM:BÉPO, $NOTIF"
  fi
}

setup_ergodox () {
  # Ergodox → toujours en bépo sans options
  for id in $(xinput list | grep -i "ergodox" | cut -d= -f2 | cut -f1); do
    #pour l'élément(device), avec esgodox dans le nom, trouvé avec xinput, enlève tout jusqu'au signe «=» inclu et ne garde que deux charactère qui sera conservé dans la variable «id»
    setxkbmap fr $BEPO_VERSION -device "$id" -option 2> /dev/null
    ERGODOX="true"
  done
  if [ -n "$ERGODOX" ] && [ ! "BÉPO" == "$NOTIF" ];
  then
    NOTIF="EZ:BÉPO, $NOTIF"
  fi
}

setup_default () {
  case $LAYOUT in
    "fr(bepo)")
      setxkbmap fr -option
      #-option enleve les options établi précédement
      echo "fr" > "$KBD_FILE"
      NOTIF="AZERTY"
      ;;
    *)
      setxkbmap fr $BEPO_VERSION -option ctrl:nocaps compose:prsc
      #ctrl:nocaps pour mettre la touche ctrl à la place de maj; compose:prsc compose sur la touche «print screen»
      echo "fr(bepo)" > "$KBD_FILE"
      NOTIF="BÉPO"
      ;;
  esac
}

main () {
  setup_default
  #le setup default change la configue pour tout le monde et setup_ergodox applique que pour les ergodox, donc l'ordre des appels est importante.
  setup_typematrix
  setup_ergodox
  #l'ergodox sera tjr en bépo
  notif-change-layout "$NOTIF"
  #déclanche les notifs 
  [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
  #active la touche compose 
}

main
# EOF

