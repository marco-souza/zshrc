# Setup ZSH
# ======================
  # Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh
  export ZSH_CUSTOM=$ZSH/custom
  if [ ! -e $ZSH ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git $ZSH
  fi

  # Compilation flags
  export ARCHFLAGS="-arch x86_64"

  # ssh
  export SSH_KEY_PATH="~/.ssh/rsa_id"

  # Themes
  ZSH_THEME="random"
  ZSH_THEME_RANDOM_CANDIDATES=(
    spaceship-prompt
    # cloud
    # af-magic
    # robbyrussell
    # robbyrussell
    # flazz
    # agnoster
  )

  # Uncomment the following line to change how often to auto-update (in days).
  export UPDATE_ZSH_DAYS=7

  # Uncomment the following line to enable command auto-correction.
  ENABLE_CORRECTION="true"

  # Uncomment the following line to display red dots whilst waiting for completion.
  COMPLETION_WAITING_DOTS="true"

  # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
  HIST_STAMPS="dd-mm-yyyy"
  # Plugins
    ZSH_PLUGINS_HOME=$ZSH/custom/plugins

    # download autosuggestions
    ZSH_AUTOSUGGESTIONS=$ZSH_PLUGINS_HOME/zsh-autosuggestions
    if [ ! -e $ZSH_AUTOSUGGESTIONS ]; then
      git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_AUTOSUGGESTIONS
    fi

    # download wakatime
    WAKATIME_PLUGINS=$ZSH_PLUGINS_HOME/zsh-wakatime
    if [ ! -e $WAKATIME_PLUGINS ]; then
      git clone https://github.com/wbingli/zsh-wakatime.git $WAKATIME_PLUGINS
    fi

    # download spaceship-prompt theme
    OMZ_THEME=$ZSH_CUSTOM/themes/spaceship-prompt
    dest="$ZSH/themes/spaceship-prompt.zsh-theme"
    if [ ! -e $dest ]; then
      git clone https://github.com/denysdovhan/spaceship-prompt.git $OMZ_THEME
      ln -s "$OMZ_THEME/spaceship.zsh-theme" $dest

      # Install Powerline fonts
      git clone https://github.com/powerline/fonts.git --depth=1
      cd fonts
      ./install.sh
      cd ..
      rm -rf fonts
    fi

    # select plugins
    plugins=(
      git
      npm
      docker
      ansible
      kubectl
      golang
      python
      zsh-autosuggestions
    )

  source $ZSH/oh-my-zsh.sh

# Ruby Setup
# ===================
  # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
  export PATH="$PATH:$HOME/.rvm/bin"

  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# Python Setup
# ===================
  # pip/pip3
  if [ ! -x "$(command -v pip)" ]; then
    if [ -x "$(command -v pip3)" ]; then
      alias pip=pip3
    else;
      if [ -x "$(command -v python3)" ]; then
        python3 <(curl -s  https://bootstrap.pypa.io/get-pip.py)
        alias pip=pip3
      else;
        python <(curl -s  https://bootstrap.pypa.io/pip/2.7/get-pip.py)
      fi
    fi
  fi

  # virtualenv
  if [ ! -x "$(command -v virtualenvwrapper.sh)" ] || [ ! -x "$(command -v wakatime)" ]; then
    pip install --user virtualenv virtualenvwrapper wakatime
  fi
  export ENVS=$HOME/.virtualenvs/
  if [ ! -e $ENVS ]; then
    mkdir -p $ENVS
  fi
  export VIRTUALENVWRAPPER_PYTHON=$(which python3)
  VENV_WRAPPER=$(which virtualenvwrapper.sh)
  source $VENV_WRAPPER

  # pyenv
  if [ ! -x "$(command -v pyenv)" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
  else;
    echo "Please install pyenv"
  fi


# Emacs Doom Setup
# =================
  export EMACS_HOME="$HOME/.emacs.d/"
  export PATH=$PATH:$EMACS_HOME/bin
  if [ ! -e $EMACS_HOME ]; then
    source <(curl -s https://raw.githubusercontent.com/marco-souza/doom.d/main/setup.sh)
  fi


# Proton setup + protontricks
# ===================
  export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.local/share/Steam"







# Aliases Setup
# =================
  file_paths=(
    $HOME/.aliases
    
  )
  for file_path in ${file_paths[@]}; do
    if [ -f $file_path ]; then
      source $file_path
    fi
  done


# config Tilix
# ===================
  if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
  fi
