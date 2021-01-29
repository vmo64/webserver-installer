#!/bin/bash


    echo  "LAMP Stack Install Script"
    echo  "Contact me on discord NGX#6969 if you have any questions"

    echo "Do not run this script on a system with already installed/broken lamp stack or it will fail!"
    echo "Continuing in 5 seconds...."
    sleep 5

    if [ "$EUID" -ne 0 ]; then
        echo "Please run this script as root."
        
    fi

echo "Automatic architecture detection initialized..."
    MACHINE_TYPE=`uname -m`
    if [ ${MACHINE_TYPE} == 'x86_64' ]; then
        echo "64-bit server detected! OK."
        echo ""
    else
        echo "Unsupported architecture detected! Please switch to 64-bit."
        
    fi

        echo "Good to go"
        sleep 5
        


apt install nano
