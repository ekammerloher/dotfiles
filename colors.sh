#!/usr/bin/env zsh
for i in {0..255} ; do
 printf "[38;5;${i}mcolour${i}
"
done
