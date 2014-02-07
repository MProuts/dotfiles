dir=~/dotfiles          # dotfiles directory

for file in $dir/*; do
  if [ $(basename $file .sh) != "linkdotfiles" ]
  then
    echo $(basename $file .sh)
    ln -s $file ~/.$(basename $file .sh)
  fi
done
