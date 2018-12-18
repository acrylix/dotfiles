# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Path to your oh-my-zsh installation.
export ZSH=/Users/kuaiyu/.oh-my-zsh

export GOPATH=/Users/kuaiyu/Documents/go
export PYPATH=/Users/kuaiyu/Library/Python/2.7/

export PATH=$GOPATH/bin:$PYPATH/bin:$PATH

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="spaceship"
SPACESHIP_DIR_TRUNC=2
SPACESHIP_DIR_COLOR="blue"
SPACESHIP_GIT_BRANCH_COLOR="yellow"
SPACESHIP_BATTERY_SHOW="always"
# SPACESHIP_BATTERY_THRESHOLD=60
SPACESHIP_DIR_TRUNC_PREFIX="../"
SPACESHIP_PROMPT_ADD_NEWLINE="false"
SPACESHIP_CHAR_SYMBOL="\uE0B0 "

SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  battery       # Battery level and status
  line_sep      # Line break
  char          # Prompt character
)
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# ssh-agent
zstyle :omz:plugins:ssh-agent identities id_rsa

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew npm z ssh-agent zsh-autosuggestions)

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
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias geth-rinkeby='geth --networkid=4 --datadir=$HOME/.rinkeby --ethstats='yournode:Respect my authoritah!@stats.rinkeby.io' --rpc --rpcapi db,eth,net,web3,personal --cache=1024  --rpcport 8545 --rpcaddr 127.0.0.1 --rpccorsdomain "*" --bootnodes=enode://a24ac7c5484ef4ed0c5eb2d36620ba4e4aa13b8c84684e1b4aab0cebea2ae45cb4d375b77eab56516d34bfbd3c1a833fc51296ff084b770b94fb9028c4d25ccf@52.169.42.101:30303';

# ALIASES

#MISC
alias toronto='curl wttr.in/Toronto';

#zsh reload
alias reload='source ~/.zshrc';

#atom editor
alias a='atom-beta';

# color ls
alias ll='ls -lhaG';

alias crypto='coinmon';

# GIT stuff
alias gitk='gitk 2>/dev/null'
alias gamend='git commit --amend --no-edit';
alias gp='git pull origin';
alias gs='git status';
alias gcmt='git commit -m ';
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"';
alias glg2='git log --date-order --all --graph --stat --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"';

# ip stuff
alias ip="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# folders short cut
alias ..='cd ..'
alias ...='cd ../..'

# misc
alias serve="python -m SimpleHTTPServer";

# WM
alias wm_on='brew services restart chunkwm && brew services restart skhd';
alias wm_off='brew services stop chunkwm && brew services stop skhd';

# syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPS="--extended"
export CHEATCOLORS=true

alias config='/usr/bin/git --git-dir=/Users/kuaiyu/.cfg/ --work-tree=/Users/kuaiyu'
alias f="fzf --height 90% --reverse --preview 'cat {}' --preview-window right:100"

eval $(thefuck --alias)
