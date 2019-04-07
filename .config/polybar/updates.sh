#!/usr/bin/env bash

exec 2> /dev/null

UPDATES=$(checkupdates 2>/dev/null | wc -l)
#AURUPDATES=$(aur vercmp -d custom | wc -l)
AURUPDATES=$(aur repo -u | wc -l)
if [[ "${UPDATES}" = "0" ]] && [[ "${AURUPDATES}" = "0" ]]; then
    echo ""
else
    echo "   ${UPDATES} | ${AURUPDATES}"
fi
