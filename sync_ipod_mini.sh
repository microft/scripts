#!/bin/bash

directory="/Volumes/MINI"
if [ -d $directory ]; then
    echo "iPod is mounted"
    rsync -rPk --delete --size-only /Users/luisbraga/iPodMini/Podcasts/ $directory/Podcasts/
  else 
    echo "iPod not mounted!"
fi 
