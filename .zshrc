# set environment vars
# ======================
  BROWSER='/usr/bin/google-chrome-stable'
  EDITOR='/usr/bin/vim'


# Setup ZSH
# ======================
  # a If you come from bash you might have to change your $PATH.
    export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

  # Path to your oh-my-zsh installation.
    export ZSH=$HOME/.oh-my-zsh

  # Compilation flags
    export ARCHFLAGS="-arch x86_64"

  # ssh
    export SSH_KEY_PATH="~/.ssh/rsa_id"

  # Themes
    ZSH_THEME="random"
    ZSH_THEME_RANDOM_CANDIDATES=(
      af-magic
      # robbyrussell
      # cloud
      # robbyrussell
      # avit
      # pure
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

    # download dependencies
    ZSH_PLUGINS_HOME=$ZSH/custom/plugins
    if [ ! -e $dest ]; then
      git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_PLUGINS_HOME/zsh-autosuggestions
    fi

    # select plugins
    plugins=(
      go
      git
      docker
      npm
      python
      zsh-autosuggestions
    )

  source $ZSH/oh-my-zsh.sh


# region: System Setup
# ===================
  ## Settup env language
    export LANG=pt_BR.UTF-8
    export LC_ALL=pt_BR.UTF-8

  ## Set Vim as default editor
    export EDITOR=vim
    export MANPATH=/usr/local/man:$MANPATH


# region: Go Setup
# ===============
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:/usr/local/opt/go/libexec/bin:$PATH


# region: Java Setup
# =================
  ## Java
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk/


# region: Node Setup
# =================
  ## NPM
    export NPM_HOME=$HOME/.npm-global
    export PATH=$PATH:$NPM_HOME/bin

    npm config set prefix $NPM_HOME

  ## Yarn
    export YARN_HOME=$HOME/.config/yarn
    YARN_MODULES=$YARN_HOME/global/node_modules
    export PATH=$PATH:$YARN_MODULES/.bin


# region: Python Setup
# ===================
  export PROJECT_HOME=$HOME/dev # user Workspace
  export ENVS=$HOME/.virtualenvs/
  export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

  # load virtualenvwrapper *-*
  #VENV_WRAPPER=/usr/bin/virtualenvwrapper.sh
  VENV_WRAPPER=$HOME/.local/bin/virtualenvwrapper.sh
  source $VENV_WRAPPER


# region: Snap Setup
# ===================
  export SNAP_HOME=/var/lib/snapd/snap
  export PATH=$PATH:$SNAP_HOME/bin


# region: Aliases Setup
# =================
  # file list
  file_paths=(
    $HOME/.aliases
  )
  for file_path in ${file_paths[@]}; do
    # source each file, if the path is exists
    if [ -f $file_path ]; then
      source $file_path
    fi
  done


# region: config Tilix
# ===================
  if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
  fi
