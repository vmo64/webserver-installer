#!/bin/bash

preflight(){
    output "LAMP Stack Install Script"
    output "Contact me on discord NGX#6969 if you have any questions"

    output "Do not run this script on a system with already installed/broken lamp stack or it will fail!"
    output "Continuing in 5 seconds...."
    sleep 5
    
    os_check

    if [ "$EUID" -ne 0 ]; then
        output "Please run this script as root."
        exit 3
    fi

output "Automatic architecture detection initialized..."
    MACHINE_TYPE=`uname -m`
    if [ ${MACHINE_TYPE} == 'x86_64' ]; then
        output "64-bit server detected! OK."
        output ""
    else
        output "Unsupported architecture detected! Please switch to 64-bit."
        exit 4
    
    esac
