#! /bin/bash

# Just copy everything to $HOME
echo "Setting up zsh"

# Install configs
cp -r .aliases .neovimrc .zshrc $HOME
echo " • Installing configurations..."

# Clone oh-my-zsh
OH_MY_ZSH=$HOME/.oh-my-zsh
if [ ! -e $OH_MY_ZSH ];
then
  echo " • Cloning Oh-My-Zsh in $dest..."
  git clone https://github.com/robbyrussell/oh-my-zsh.git $OH_MY_ZSH
fi

# Clone wakatime
WAKATIME_PLUGINS=$HOME/.oh-my-zsh/custom/plugins/zsh-wakatime
if [ ! -e $WAKATIME_PLUGINS ];
then
  echo " • Cloning wakatime in $WAKATIME_PLUGINS..."
  git clone https://github.com/wbingli/zsh-wakatime.git $WAKATIME_PLUGINS
fi

echo " • Applying configs to current section..."
source ~/.{aliases,zshrc}

echo " • Creating local npm folder..."
make ~/.npm-global

echo " • Install virtualenv as dependencies..."
pip install virtualenv{,wrapper} wakatime

echo " • Opening new session!"
zsh; exit

