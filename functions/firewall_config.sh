#!/usr/bin/env bash

if [[ $EUID != 0 ]]; then
    echo "Please run as root"
else

    finish=false
    while [[ $finish = false ]]; do
        read -p "Port: " port
        
        readable=false
        while [[ $readable = false ]]; do
            read -p "Status [(a)llow/(d)eny]: " status
            
            if [[ $status = "allow" ]] || [[ $status = "a" ]] || [[ $status = "deny" ]] || [[ $status = "d" ]]
            then
                if [[ $status = "a" ]]; then
                    status=allow
                elif [[ $status = "d" ]]; then
                    status=deny
                fi
                
                readable=true
            else
                echo "Please enter valid status"
            fi
        done
        
        readable=false
        while [[ $readable = false ]]; do
            read -p "Direction [(i)ncoming/(o)utgoing]: " direction
            
            if [[ $direction = "incoming" ]] || [[ $direction = "i" ]] || [[ $direction = "outgoing" ]] || [[ $direction = "o" ]]; then
                if [[ $direction = "i" ]]; then
                    direction=incoming
                elif [[ $direction = "o" ]]; then
                    direction=outgoing
                fi
                
                readable=true
            else
                echo "Please enter valid direction"
            fi
        done
        
        echo
        echo -e "Port: $port\nStatus: $status\nDirection: $direction"
        ufw $status $port $direction
        echo
        
        confirm.sh "Configure more port settings"
        if [[ $? = 2 ]]; then
            finish=true
        fi
        
    done
    
fi