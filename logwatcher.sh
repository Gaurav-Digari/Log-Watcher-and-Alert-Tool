#!/bin/bash

usage(){
    echo "========Log Watcher and Alert Tool========"
    echo
    echo "Usage : ./file_name.sh  -argument"
    echo
    echo "Options:"
    echo "-h  Help menu"
    echo "-p  Log file with file path"
    echo "-f  Log file without file path"
    echo "-k  Severity Number of which log type you want to watch only 1 or if many use commans to separate them .Like 1,3,4"
    echo 
    echo "SEVERITY LEVELS 0-EMERGENCY 1-ALERT 2-CRITICAL 3-ERROR 4-WARNING 5-NOTICE 6-INFO 7-DEBUG"
    echo
    echo "Don't use -p and -f together use only 1 at a time"
}

usage