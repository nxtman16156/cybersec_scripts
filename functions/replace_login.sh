#!/usr/bin/env bash

line=$(awk '-F\t' '($1 == "'"$1"'") {print NR}' /etc/login.defs)
if [[ $line ]]; then
    replacement=$(awk '-F\t' '($1 == "'"$1"'") {print $2}' /etc/login.defs)
    sed -i "${line}s/$replacement/$2/" /etc/login.defs
else
    echo -e "$1\t$2" >> /etc/login.defs
fi