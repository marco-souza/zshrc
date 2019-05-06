#! /bin/bash

# Just copy everything to $HOME
echo "Setting up zsh"

# Install configs
cp -r .aliases .neovimrc .zshrc $HOME
echo " • Installing configurations..."

# Clone oh-my-zsh
dest=$HOME/.oh-my-zsh
if [ ! -e $dest ];
then
  echo " • Cloning Oh-My-Zsh in $dest..."
  git clone https://github.com/robbyrussell/oh-my-zsh.git $dest
fi

echo " • Applying configs to current section..."
source ~/.{aliases,zshrc}

echo " • Creating local npm folder..."
make ~/.npm-global

echo " • Install virtualenv as dependencies..."
pip install virtualenv{,wrapper}

echo " • Opening new session!"
zsh; exit

