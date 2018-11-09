#!/bin/sh
sequential_name="trace_S.txt"
random_name="trace_R.txt"
inter_name="trace_I.txt"
sequential_Lname="trace_S.log"
random_Lname="trace_R.log"
inter_Lname="trace_I.log"
sequential_result="trace_S"
random_result="trace_R"
inter_result="trace_I"
FILESIZE_KEEP=$1
FILESIZE=$FILESIZE_KEEP
MAXSIZE=$2
MAXTIME=$3
echo "minimum filesize: $FILESIZE_KEEP"
echo "maximum filesize: $MAXSIZE"
echo "read times	   : $MAXTIME"
> $sequential_result 
> $random_result
> $inter_result
while [ $FILESIZE -lt $MAXSIZE ]
do
echo $FILESIZE
> $sequential_name
> $random_name
> $inter_name
> $sequential_Lname
> $random_Lname
> $inter_Lname
gcc -o s.out test_S.c
./s.out $MAXTIME $FILESIZE
gcc -o r.out test_R.c
./r.out $MAXTIME $FILESIZE
gcc -o i.out test_I.c
./i.out $MAXTIME $FILESIZE

../trace $sequential_name > $sequential_Lname 
tail -n 8 $sequential_Lname | grep "read misses" |  awk -F: '{print $3}' | sed 's/ //g' >> $sequential_result 
../trace $random_name > $random_Lname
tail -n 8 $random_Lname | grep "read misses" |  awk -F: '{print $3}' | sed 's/ //g'>> $random_result 
../trace $inter_name > $inter_Lname
tail -n 8 $inter_Lname | grep "read misses" |  awk -F: '{print $3}' | sed 's/ //g'>> $inter_result 
FILESIZE=$(($FILESIZE+1))
sleep .1
done

python cs4411.py $sequential_result $random_result $inter_result $FILESIZE_KEEP $MAXSIZE
