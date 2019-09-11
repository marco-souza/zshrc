#! /bin/bash

# Install configs
echo " • Installing configurations..."
cp -r .aliases .zshrc $HOME

# Install dependencies
yay -Sy --noconfirm python-pip nodejs npm

# Clone oh-my-zsh
OMZ=$HOME/.oh-my-zsh
if [ ! -e $OMZ ];
then
  echo " • Cloning Oh-My-Zsh in $OMZ..."
  git clone https://github.com/robbyrussell/oh-my-zsh.git $OMZ
fi

# Creating workspace if not exsits
WORKSPSACE=$HOME/dev
if [ ! -e $WORKSPSACE ];
then
  echo " • Creating workspsace..."
  mkdir $WORKSPSACE
fi

echo " • Applying configs to current section..."
source ~/.{aliases,zshrc}

echo " • Creating local npm folder..."
make ~/.npm-global

echo " • Install virtualenv as dependencies..."
pip install --user virtualenv{,wrapper}

echo " • Opening new session!"
zsh; exit

