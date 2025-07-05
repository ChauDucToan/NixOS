#!/bin/bash

num=0;
while true; do 
    echo "========SETUP========"
    echo "1. Build system configuration"
    echo "2. Build home configuration"
    echo "3. Auto ssh eval"
    echo "====================="

    read -rp "Choose an option (1-3): " num
    if [[ "$num" =~ ^[1-3] ]]; then
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
    "3")
        eval "$(ssh-agent)"
        while true; do
            read -rp "Enter SSH key name (without .pub) in \$HOME: " p
            if [[ -e "$HOME/.ssh/$p" && -e "$HOME/.ssh/$p.pub" ]]; then
                ssh-add "$HOME/.ssh/$p"
                break
            else
                echo "Key not found at $HOME/.ssh/$p — please try again"
            fi
        done
        ;;
esac

