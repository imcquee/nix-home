#!/usr/bin/env bash

serpl
exit_code=$?

if [[ $exit_code -eq 0 ]]; then
    zellij action toggle-floating-panes
    zellij action write-chars ":reload-all"
    zellij action write 13 # send <Enter> key
fi
