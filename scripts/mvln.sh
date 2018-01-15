file=$(realpath $1)
dest=$(realpath $2)
base=$(basename $file)

echo "moving file '$base' from $file to $dest. Linking back $dest/$base to $PWD"

mv $file $dest
ln -s "$dest/$base" $PWD
