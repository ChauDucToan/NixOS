#!/bin/bash

function isTemplates() {
    if [[ $# -eq 1 ]]; then
        folder=${1%/*}
        if [[ -d $folder ]] && [[ ${folder##*/} == "Templates" ]]; then
            echo 1
        else
            echo "You should create a Templates folder"
            echo 0
        fi
    fi
}

set -- "./Templates/Zettle.md" "$1"
if [[ $(isTemplates $1) ]] && [[ -e $1 ]]; then
    if [[ -z $2 ]]; then
        set -- "$1" "$(date "+%d%m%Y")"
    fi        
    for i in "${@:2}"; do
        while read line; do
            line=${line/"{{title}}"/$i}
            line=${line/"{{date}}"/"$(date "+%d-%m-%Y")"}
            echo $line >> ./$i.md
        done < $1
    done
else
    echo "There is no Templates folder in $(pwd)"
fi
