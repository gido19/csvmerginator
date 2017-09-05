#!/bin/sh

if [ $# -lt 3 ]; then
    echo "Usage: sh merge.sh <outputfile.csv> <input files>"
    exit -1
fi

echo "Output file:" $1
OUTPUT=$1
shift
echo "Input file list:" $@
FIRST_FILE=$1

head -1 $FIRST_FILE | sed "s/^/stitch,coupe,observer,id/" > $OUTPUT
for f in $@; do
    echo "Processing file $f ..."
    STITCH=`echo $f | cut -f1 -d_`
    COUPE=`echo $f | cut -f2 -d_`
    OBSERVER=`echo $f | cut -f3 -d_ | cut -f1 -d.`
    tail -n+2 $f | sed "s/^/$STITCH,$COUPE,$OBSERVER,/" >> $OUTPUT
done
