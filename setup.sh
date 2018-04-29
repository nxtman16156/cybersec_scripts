#!/usr/bin/env bash
# Peter Russell

# Initializes behavior shell variable
behavior=ask

# Parses flags
# Accepted flags: y n

while getopts :yn opt
do
    case $opt in
        y)
            behavior=yes
            ;;
        n)
            behavior=no
            ;;
        \?)
            echo "Please supply a valid flag"
            exit 1
            ;;
    esac
done

# Check if user is root or running script under sudo
if [ "$EUID" -ne 0 ]
then
    echo "Please run as root"
else
    # Tell kernel to allow the scripts in scripts/ to be executed
    chmod +x $(pwd)/scripts/*
    
    # Append scripts/ to PATH
    export PATH=$PATH:$(pwd)/scripts
    
    # Loop through each file in scripts/
    for file in scripts/*
    do
        if [[ $behavior = yes ]]
        then
            # Run each script in scripts/
            $file
        elif [[ $behavior = ask ]]
        then
            finished=false
            # Keep asking for answer until a valid one is given
            while [[ $finished = false ]]
            do
                read -p "Run the script: ${file}? [y/n] " answer
                if [[ $answer = y ]] || [[ $answer = n ]]
                then
                    finished=true
                else
                    echo "Please enter a valid answer"
                fi
            done
            if [[ $answer = y ]]
            then
                $file
            fi
        fi
    done
fi

exec /bin/bash