#!/bin/sh
# common functionality for the unit tests



rdfind=$(pwd)/rdfind

#bail out on the first error
set -e

#where is the test scripts dir?
testscriptsdir=$(dirname $(readlink -f $0))


dbgecho() {
    echo "$0 debug: " "$@"
}

echo -n "checking for rdfind ..."
if [ ! -x "$rdfind" ]; then
    echo "could not find $rdfind"
fi
echo " OK."

echo -n "checking for mktemp ..."
which mktemp >/dev/null
echo " OK."

#create a temporary directory, which is automatically deleted
#on exit
datadir=$(mktemp -d -t rdfindtestcases.d.XXXXXXXXXXXX)
dbgecho "temp dir is $datadir"

cleanup () {
cd /
rm -rf "$datadir"
}

trap cleanup 0

[ -d $datadir ]
cd $datadir

reset_teststate() {
    cd /
    rm -rf "$datadir"
    mkdir -p $datadir
    cd "$datadir"
}



