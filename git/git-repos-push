#!/bin/sh
logfile=git-repos-push.log
echo "========================================================" | tee -a $logfile
date +"[%Y-%m-%d %H:%M:%S] Started:" | tee -a $logfile
reposman -to-remote "$@" 2>&1 | tee -a $logfile
date +"[%Y-%m-%d %H:%M:%S] Finished." | tee -a $logfile
