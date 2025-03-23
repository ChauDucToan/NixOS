#!/bin/bash

num=0;
while :
do 
    echo "========SETUP========"
    echo "1. Build system configuration"
    echo "2. Build home configuration"
    echo "====================="

    read num
    if [[ "$num" =~ ^[1-2] ]]; then
        break
    else 
        echo "Please choose the right option"
    fi
done

case $num in
    "1")
        eval "sudo nixos-rebuild switch --flake .#$(whoami)";;
    "2")
        eval "home-manager switch --flake .#$(whoami)";;
esac

