#!/bin/bash
# .bashrc
# sej 2016 03 14



# Load custom settings, aliases, completion, plugins
for file_type in "settings" "aliases" "completion" "plugins"
do
    CUSTOM=~/.shell/${file_type}/*.sh
    for config_file in $CUSTOM
    do
	if [ -e $config_file ]; then
	    echo $config_file
	    source $config_file
        fi
    done
done

unset config_file

