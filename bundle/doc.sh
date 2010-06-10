#!/bin/sh
# Indexes the documentation in the bundles in this directory.
MYDIR=`dirname $0`
cd $MYDIR
for dir in */doc/; do
    if uname -a | grep --silent -i 'Darwin'
    then
        mvim -u NONE -c "helptags $dir" -c quit
    else
        vim -u NONE -c "helptags $dir" -c quit
    fi
done
