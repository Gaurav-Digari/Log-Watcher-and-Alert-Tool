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

check_path() {
    local temp=$(dirname "$path")
    if [ -d "$temp" ]; then 
        if [ -f "$path" ];then
        log=$(basename "$path")
        return
        else
           echo "File Does not exists in your given path check Your path/file"
           exit 1
        fi
    else 
        echo "Path does not check Your path"
        exit 1
    fi
}

check_file() {
    local temp="$file"
    if [ -s "$temp" ];then
        log="$file"
        return
    else
        echo "File Does not exists check Your file"
        exit 1
    fi
}

while getopts ":hp:f:k:" opt
do
  case $opt in
  p) file="$OPTARG"
    check_path ;;
  f) file="$OPTARG"
    check_file;;
  k) IFS=',' read -ra levels <<< "$OPTARG";;
  h) usage
  exit 1 ;;
  *) usage 
    exit 1 ;;
  esac
done

for level in "${levels[@]}"
do 
  case "$level" in
    0)
     severity="EMERGENCY";;
    1)
     severity="CRITICAL" ;;
    2)
      severity="ALERT" ;;
    3)
      severity="ERROR";;
    4)
      severity="WARNING" ;;
    5)
      severity="NOTICE" ;;
    6)
      severity="INFO";;
    7)
     severity="DEBUG" ;;
    *)
      echo "Invalid level: $level"; 
      continue ;;
    esac

    severity_levels+=($severity)
done
    

