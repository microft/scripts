#!/bin/bash
COMMAND=`which checkgmail`
for i in ~/.checkgmail/prefs*.xml ; do
  $COMMAND -profile=$(expr $i : ".*prefs-\(.*\).xml$") &
done

