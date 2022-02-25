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
  ZSH_THEME="cloud"
  # ZSH_THEME_RANDOM_CANDIDATES=(
    # cloud
    # af-magic
    # robbyrussell
    # robbyrussell
    # flazz
    # agnoster
  # )

  # Uncomment the following line to change how often to auto-update (in days).
  export UPDATE_ZSH_DAYS=3

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
  VENV_WRAPPER=$(which virtualenvwrapper.sh)
  source $VENV_WRAPPER

# Emacs Doom Setup
# =================
  if [ ! -e $EMACS_HOME ]; then
    source <(curl -s https://raw.githubusercontent.com/marco-souza/doom.d/main/setup.sh)
  fi




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
