if [ "$#" -ge 1 ]
then

if [ $1 = '-a' ] && [ "$#" -gt 1 ]

then

while [ "$#" -gt 1 ]
do

echo "Ilość plików w katalogu $2:"
ls -1a "$2" | wc -l
shift

done

elif [ $1 = '-a' ] && [ "$#" -eq 1 ]
then 
echo "Ilość plików w katalogu bieżącym:"
ls -1a | wc -l

else

while [ "$#" -ge 1 ]
do
echo "Ilość plików w katalogu $1:"
ls -1 "$1" | wc -l
shift

done

fi

else

echo "Ilość plików w katalogu bieżącym:"
ls -1 | wc -l

fi
