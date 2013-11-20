#!/bin/bash

#
# Use this with data from http://skat.dk/opengovcamp/
#
# Not a very efficient script, I know. Hopefully it is simple to extend.
# Toke Eskildsen, te@ekot.dk
#
# No copyright enforced whatsoever. Extend, modify, distribute at will.
# Feel free to credit me, but it is not a requirement.
#
# Requirements: bash, gnuplot
#

# 4=køn, 5=alder, 25=Personlig indkomst

PERCENTILES="0.25 0.5 0.75 0.95"
COLUMN=25
DESIGNATION="Personlig indkomst"
DATA="OpenGovCamp.csv"

echo -n "Extracting ages... "
AGES=`cat "$DATA" | tail -n +2 | cut -d\; -f5 | sort | uniq`
echo -n "Got "
echo "$AGES" | tr '\n' ' '
echo ""

for SEX in Mand Kvinde; do
    OUT="${SEX}.dat"
    echo "Generating $OUT"

    echo "# Data extracted from $DATA at `date`" > $OUT
    echo "# Sex is '$SEX', column is $COLUMN ($DESIGNATION)" >> $OUT
    echo -n "# Age" >> $OUT
    for PERCENTILE in $PERCENTILES; do
        echo -n " p$PERCENTILE" >> $OUT
    done
    echo " mean" >> $OUT

    for AGE in $AGES; do
        echo "- Calculating percentiles and mean for column $COLUMN ($DESIGNATION) for $SEX $AGE"

        echo -n $AGE >> $OUT
        VALUES=`tempfile`
        # Collect sorted income for all sex,age
        cat "$DATA" | tail -n +2 | cut -d\; -f4,5,$COLUMN | grep "${SEX};${AGE};" | cut -d\; -f3 | sed 's/\.//g' | sort -n > $VALUES
        COUNT=`cat $VALUES | wc -l`
        # Extract the wanted percentiles
        for PERCENTILE in $PERCENTILES; do
            POS=`echo "scale=0;$PERCENTILE*$COUNT/1" | bc`
            echo -n " " >> $OUT
            head -n $POS $VALUES | tail -n 1 | tr -d '\n' >> $OUT
        done
        echo -n " " >> $OUT
        awk '{ total += $1; count++ } END { print total/count }' $VALUES >> $OUT
        rm $VALUES
    done
done
paste -d\  Kvinde.dat Mand.dat > KvindeMand.dat

echo "Generating graphs"
export TITLE="Percentiler for $DESIGNATION fordelt på køn og alder"
export YLABEL="$DESIGNATION"
for GP in `ls *.gp`; do
    echo "- $GP"
    gnuplot $GP
done
echo "Finished. Please view indkomst.png"
