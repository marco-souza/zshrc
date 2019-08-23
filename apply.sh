#! /bin/bash

# Install configs
cp -r .aliases .zshrc $HOME
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
sudo pip install virtualenv{,wrapper}

echo " • Opening new session!"
zsh; exit

