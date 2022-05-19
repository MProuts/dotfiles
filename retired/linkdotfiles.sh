dir=~/dotfiles          # dotfiles directory

for file in $dir/*; do
  if [ $(basename $file .sh) != "linkdotfiles" ]
  then
    echo "Linking" $(basename $file) "..."
    ln -s $file ~/.$(basename $file .sh)
  fi
done
echo "... all done!"
