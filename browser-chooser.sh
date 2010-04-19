#!/bin/bash
# The last option should be the default. To be used if none are running
BROWSERS=( firefox chromium-browser opera google-chrome x-www-browser )
for browser in ${BROWSERS[@]}; do
  RUNNING=$(pgrep -u $USER -f $browser);
  if [ "$RUNNING" ]; then
    break
  fi
done

COMMAND=$(type -P $browser);
exec $COMMAND "$@"
