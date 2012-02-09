#!/bin/bash
# a small script to rsync podcasts into my iPod Mini (running Rockbox)

directory="/Volumes/MINI"
if [ -d $directory ]; then
    echo "iPod is mounted"
    rsync -rPk --delete --size-only /Users/luisbraga/iPodMini/Podcasts/ $directory/Podcasts/
  else 
    echo "iPod not mounted!"
fi 
