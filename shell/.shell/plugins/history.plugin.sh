#!/bin/bash
# history.plugin.sh
# sej 2016 03 15


# enter a few characters and press UpArrow/DownArrow
# to search backwards/forwards through the history
if [ -t 1 ]; 
then
    bind '"[A":history-search-backward'
    bind '"[B":history-search-forward'
fi
