dir=~/dotfiles          # dotfiles directory
files="bash_profile vimrc"    # list of dotfiles to link

for file in $files; do
  ln -s $dir/$file.sh ~/.$file
done
