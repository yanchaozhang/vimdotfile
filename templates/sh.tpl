#!/bin/sh

if [ -z $1 ]; then
    echo "Usage: $0 linux|other"
    exit 1
fi
echo "$1"
if [ "$1" = "linux" ]; then
    echo "you said linux"
else
    echo "you said something else besides linux"
fi
if [ ! -f $0 ];
then
    echo "This isn't supposed to happen"
else
    echo "I exist."
fi
