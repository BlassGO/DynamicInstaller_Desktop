#!/bin/bash
[ -n "$BASH_VERSION" ] && {
    ___WORKDIR=${BASH_SOURCE[0]}
    [ -f "$___WORKDIR" ] || ___WORKDIR="$0"
} || ___WORKDIR="$0"
[ -f "$___WORKDIR" ] && ___WORKDIR="$(cd "$(dirname "$___WORKDIR")" >/dev/null 2>&1 && pwd)" || ___WORKDIR="$(pwd)"

___MYPATH="$___WORKDIR/utils/di"

if [ -f "$___MYPATH/setup" ]; then
   cd "$___WORKDIR"
   . "$___MYPATH/setup"
else
    echo "ERROR: Cant find \"$___MYPATH/setup\" file" 1>&2
    exit 1
fi