#!/bin/bash
#
# If you make this script your default browser when you click on a link
# it'll look at running browsers and open the link on the first available one
#
# If there isn't a browser running, it'll launch the last one
#

# The last option should be the default. To be used if none are running
BROWSERS=( firefox chromium-browser opera /opt/google/chrome/chrome x-www-browser )

for browser in ${BROWSERS[@]}; do
  RUNNING=$(pgrep -u $USER -f $browser);
  if [ "$RUNNING" ]; then
    break
  fi
done

COMMAND=$(type -P $browser);
exec $COMMAND "$@"
