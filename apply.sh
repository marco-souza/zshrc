#! /bin/bash
LI='\b  • '
function useDir {
  DIR=$1
  MSG=${2:-"$LI Creating $DIR..."}
  CMD=${3:-"mkdir"}

  if [ ! -e $DIR ]; then
    echo "$MSG"
    $CMD $DIR
  fi
}


# Install configs
echo "$LI Installing configurations..."
cp -r .aliases .zshrc $HOME


# Install dependencies
apt install git python-pip nodejs npm zsh curl unzip
# yay -Sy --noconfirm python-pip nodejs npm deno


# Install Deno
curl -fsSL https://deno.land/x/install/install.sh | sh


# Clone oh-my-zsh
ZSH_CUSTOM=$HOME/.oh-my-zsh
useDir $ZSH_CUSTOM "$LI Cloning Oh-My-Zsh in $ZSH_CUSTOM..." 'git clone https://github.com/robbyrussell/oh-my-zsh.git'


# Clone spaceship-prompt
OMZ_THEME=$ZSH_CUSTOM/themes/spaceship-prompt
useDir $OMZ_THEME "$LI Cloning Oh-My-Zsh in $OMZ_THEME..." 'git clone https://github.com/denysdovhan/spaceship-prompt.git'


# Creating workspace if not exsits
WORKSPSACE=$HOME/dev
useDir $WORKSPSACE


# Clone wakatime
WAKATIME_PLUGINS=$ZSH_CUSTOM/custom/plugins/zsh-wakatime
useDir $WAKATIME_PLUGINS "$LI Cloning zsh-wakatime in $WAKATIME_PLUGINS..." 'git clone https://github.com/wbingli/zsh-wakatime.git'


echo "$LI Applying configs to current section..."
source ~/.aliases ~/.zshrc

echo "$LI Creating local npm folder..."
make ~/.npm-global

echo "$LI Install virtualenv as dependencies..."
pip install --user virtualenv virtualenvwrapper wakatime

echo "$LI Opening new session!"
zsh; exit

