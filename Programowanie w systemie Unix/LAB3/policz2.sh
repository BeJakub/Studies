if [ "$#" -ge 1 ]
then

for i in "$@"
do

if test $1 = '-a'
then

if test "$#" -gt 2
then

ls -1a "$i"
ls -1a "$i" | wc -l

else

ls -1a
ls -1a | wc -l

fi
fi
shift


done

else

ls -1
ls -1 | wc -l

fi
