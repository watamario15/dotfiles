#!/usr/bin/env bash

DICTDIR=~/Documents/Dictionaries
MKXTBDIR=~/MkXTBWikiplexus/build.unix
PLIST=~/dotfiles/tools/info-plists

set -e
if(test $# -ne 2) ; then
    echo "Error: Invalid Parameter."
    echo "Usage: [WikiName] [Date]"
    echo "Example: ./XTBook_Article jawiki 20210401"
    echo "         ./XTBook_Article jaunwiki 20210401"
    exit
fi

mkdir -p ${DICTDIR}
cd ${DICTDIR}
echo "Running MkXTBWikiplexus..."
${MKXTBDIR}/MkXTBWikiplexus-bin -o $1-$2.xtbdict < $1-$2-pages-articles.xml &> /dev/null
cd $1-$2.xtbdict
echo "Running YomiGenesis..."
${MKXTBDIR}/YomiGenesis-bin < BaseNames.csv > Yomi.txt 2> /dev/null
${MKXTBDIR}/MkXTBIndexDB-bin -o Search Yomi.txt
${MKXTBDIR}/MkRax-bin -o Articles.db.rax  < Articles.db
rm -f Articles.db Yomi.txt BaseNames.csv Titles.csv
cp ${PLIST}/$1.plist info.plist
