# set environment vars
# ======================
  export BROWSER='/usr/bin/brave'
  export SHELL="/bin/zsh"
  export EDITOR=vim
  export WORKSPACE=$HOME/dev # user Workspace


# Setup user profile
# ======================
  # a If you come from bash you might have to change your $PATH.
  export PATH=$PATH:$HOME/.local/bin:/usr/local/bin
  export ARCHFLAGS="-arch x86_64"
  export SSH_KEY_PATH="~/.ssh/rsa_id"


# System Setup
# ===================
  ## Settup env language: https://wiki.archlinux.org/index.php/Locale
  export LANG=pt_BR.UTF-8
  export LC_ALL=pt_BR.UTF-8


# Go Setup
# ===============
  export GOPATH=$WORKSPACE/go
  export GO_GLOBAL=/usr/local/opt/go/libexec/bin
  export PATH=$PATH:$GOPATH/bin:$GO_GLOBAL:$PATH
  if [ ! -x "$(command -v go)" ]; then
    wget -c https://golang.org/dl/go1.17.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
  fi
  if [ ! -e $GOPATH ]; then
    mkdir -p $GOPATH
  fi


# Rust Setup
# =================
  export RUST_HOME="$HOME/.cargo"
  export PATH=$PATH:$RUST_HOME/bin
  if [ ! -x "$(command -v cargo)" ] || [ ! -x "$(command -v rustc)" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi


# Deno Setup
# =================
  export DENO_HOME="$HOME/.deno"
  export PATH=$PATH:$DENO_HOME/bin
  if [ ! -e $DENO_HOME ]; then
    mkdir -p $DENO_HOME
  fi
  if [ ! -x "$(command -v deno)" ]; then
    cargo install deno
  fi


# Node Setup
# =================
  ## NPM
  export NPM_HOME=$HOME/.npm-global
  export PATH=$PATH:$NPM_HOME/bin
  npm config set prefix $NPM_HOME
  if [ ! -e $NPM_HOME ]; then
    mkdir -p $NPM_HOME
  fi

  ## Yarn
  export YARN_HOME=$HOME/.config/yarn
  export PATH=$PATH:$YARN_HOME/global/node_modules/.bin
  if [ ! -e $YARN_HOME ]; then
    npm i -g yarn
    mkdir -p $YARN_HOME
  fi

# Ruby Setup
# ===================
  # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
  export PATH="$PATH:$HOME/.rvm/bin"

  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# Python Setup
# ===================
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



# Snap Setup
# ===================
  export SNAP_HOME=/var/lib/snapd/snap
  export PATH=$PATH:$SNAP_HOME/bin




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