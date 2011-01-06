#!/bin/bash
for i in ~/.checkgmail/prefs*.xml ; do
  checkgmail -profile=$(expr $i : ".*prefs-\(.*\).xml$") &
done

