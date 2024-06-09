#!/usr/bin/bash
source functions.sh

echo
echo "List of available servers:"
echo
grep '\[*\]' $CONFIG_FILEPATH | nl -w1 -n ln -s ') '
echo