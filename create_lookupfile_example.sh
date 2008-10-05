#!/bin/sh
# This script generates a file calle 'filenametags'
# that contains all the crappy files in the current directory
# and subdirectories
(echo "!_TAG_FILE_SORTED	2	/2=foldcase/";
find . \( -name .svn -o -wholename ./classes -o -wholename ./vendor -o -wholename ./tmp \) -prune -o -not -iregex '.*\.\(jar\|gif\|jpg\|class\|exe\|dll\|pdd\|sw[op]\|xls\|doc\|pdf\|zip\|tar\|ico\|ear\|war\|dat\).*' -type f -printf "%f\t%p\t1\n" | \
sort -f) > ./filenametags
