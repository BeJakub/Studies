for in in $1
do
x=echo $i |sed 's/'$1'/_arch'$1'/g' 
cp -p $i $HOME/.arch/"$x"
done
