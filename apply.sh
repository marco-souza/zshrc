# Just copy everything to $HOME
echo "Setting up zsh"
# Install configs
cp -r .aliases .neovimrc .zsh-update .zshrc .oh-my-zsh $HOME
# Clone oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
echo "Done "