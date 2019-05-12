# region: Oh-My-Zsh setup
# ======================
  # a If you come from bash you might have to change your $PATH.
    export PATH=$HOME/bin:/usr/local/bin:$PATH

  # Path to your oh-my-zsh installation.
    export ZSH=$HOME/.oh-my-zsh

  # Set name of the theme to load. Optionally, if you set this to "random"
  # it'll load a random theme each time that oh-my-zsh is loaded.
  # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

  # Themes
    ZSH_THEME="random"
    ZSH_THEME_RANDOM_CANDIDATES=(
      # "robbyrussell"
      "af-magic"
      # "cloud"
    )
    #ZSH_THEME="robbyrussell"
    # ZSH_THEME="avit"
    # ZSH_THEME="pure"
    # ZSH_THEME="flazz"
    # ZSH_THEME="agnoster"

  # Uncomment the following line to use case-sensitive completion.
  # CASE_SENSITIVE="true"

  # Uncomment the following line to use hyphen-insensitive completion. Case
  # sensitive completion must be off. _ and - will be interchangeable.
  # HYPHEN_INSENSITIVE="true"

  # Uncomment the following line to disable bi-weekly auto-update checks.
  # DISABLE_AUTO_UPDATE="true"

  # Uncomment the following line to change how often to auto-update (in days).
    export UPDATE_ZSH_DAYS=7

  # Uncomment the following line to disable colors in ls.
  # DISABLE_LS_COLORS="true"
  # Custom LS_COLORS

  # Uncomment the following line to disable auto-setting terminal title.
  # DISABLE_AUTO_TITLE="true"

  # Uncomment the following line to enable command auto-correction.
    ENABLE_CORRECTION="true"

  # Uncomment the following line to display red dots whilst waiting for completion.
    COMPLETION_WAITING_DOTS="true"

  # Uncomment the following line if you want to disable marking untracked files
  # under VCS as dirty. This makes repository status check for large repositories
  # much, much faster.
  # DISABLE_UNTRACKED_FILES_DIRTY="true"

  # Uncomment the following line if you want to change the command execution time
  # stamp shown in the history command output.
  # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
    HIST_STAMPS="dd-mm-yyyy"

  # Would you like to use another custom folder than $ZSH/custom?
  # ZSH_CUSTOM=/path/to/new-custom-folder

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  # Add wisely, as too many plugins slow down shell startup.

  #Plugins
    # Plugin dependencies
    dest=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    if [ ! -e $dest ]; then
      git clone https://github.com/zsh-users/zsh-autosuggestions $dest
    fi

    # Plugin selection
    plugins=(
      git
      docker
      npm
      ruby
      rake
      python
      zsh-autosuggestions
    )

  source $ZSH/oh-my-zsh.sh

  # User configuration

  # export MANPATH="/usr/local/man:$MANPATH"

  # You may need to manually set your language environment
  # export LANG=en_US.UTF-8

  # Preferred editor for local and remote sessions
  # if [[ -n $SSH_CONNECTION ]]; then
  #   export EDITOR='vim'
  # else
  #   export EDITOR='mvim'
  # fi

  # Compilation flags
    export ARCHFLAGS="-arch x86_64"

  # ssh
    export SSH_KEY_PATH="~/.ssh/rsa_id"

  # Set personal aliases, overriding those provided by oh-my-zsh libs,
  # plugins, and themes. Aliases can be placed here, though oh-my-zsh
  # users are encouraged to define aliases within the ZSH_CUSTOM folder.
  # For a full list of active aliases, run `alias`.
  #
  # Example aliases
  # alias zshconfig="mate ~/.zshrc"
  # alias ohmyzsh="mate ~/.oh-my-zsh"


# region: System Setup
# ===================
  ## Set Language environment
    export LANG=pt_BR.UTF-8
    export LC_ALL=pt_BR.UTF-8

  ## Set Vim as default editor
    export EDITOR='vim'
    export MANPATH="/usr/local/man:$MANPATH"


# region: Go Setup
# ===============
  export GOPATH=$HOME/.go
  export PATH=$PATH:/usr/local/opt/go/libexec/bin


# region: Java Setup
# =================
  ## Java
    export JAVA_HOME='/usr/lib/jvm/java-8-openjdk/'

  ## Spark
    SPARK_HOME="/opt/apache-spark"
    export PATH=$(echo "$PATH:$SPARK_HOME/bin")

  ## SDKMAN
  #. "$HOME/.sdkman/bin/sdkman-init.sh"

  ## Android
    export ANDROID_HOME="$HOME/.Android/Sdk"
    # export PATH=$(echo "$PATH:$ANDROID_HOME/tools")
    export PATH=$(echo "$PATH:$ANDROID_HOME/emulator")
    export PATH=$(echo "$PATH:$ANDROID_HOME/platform-tools")


# region: Node Setup
# =================
  ## NPM
    NPM_GLOBAL="${HOME}/.npm-global"
    npm config set prefix $NPM_GLOBAL
    PATH="$NPM_GLOBAL/bin:$PATH"
  # Unset manpath so we can inherit from /etc/manpath via the `manpath` command
    unset MANPATH # delete if you already modified MANPATH elsewhere in your config
    export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

  ## NVM
    export NVM_DIR="$HOME/.nvm"

  ## Yarn
    export PATH=$(echo "$PATH:$HOME/.config/yarn/global/node_modules/.bin")


# region: Python Setup
# ===================
  ## Python paths
    PYTHON3_PATH="/usr/local/lib/python3.7/site-packages"
    ENVS="$HOME/.virtualenvs/"
    PATH="$PATH:$PYTHON3_PATH"

  ## Anaconda
    export PATH="$PATH:/opt/anaconda/bin"

  ## Virtualenv Wrapper - Setup
    export VENV_WRAPPER="/usr/local/bin/virtualenvwrapper.sh"
    export PROJECT_HOME="$HOME/dev"
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.7
    source $VENV_WRAPPER


# region: Ruby Setup
# ===================
  # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    export PATH="$PATH:$HOME/.rvm/bin"
    source $HOME/.rvm/scripts/rvm


# region: Load Files
# =================
  files=(".aliases" )
  files_path="$HOME/"
  for file in ${files[@]}; do
      file_to_load=$files_path$file;
      if [ -f $file_to_load ]; then
          source $file_to_load
      fi
  done


# region: config Tilix
# ===================
  if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
  fi
