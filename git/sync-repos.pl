#!/bin/sh
script="reposman --to-remote"
logfile="sync-repos.log"
echo "========================================================" | tee -a $logfile
echo $script "$@" | tee -a $logfile
date +"[%Y-%m-%d %H:%M:%S] Started:" | tee -a $logfile
$script "$@" 2>&1 | tee -a $logfile
date +"[%Y-%m-%d %H:%M:%S] Finished." | tee -a $logfile
echo

