# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/johnduro/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Oh My Zsh auto-update
DISABLE_UPDATE_PROMPT=true

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(colored-man-pages git sudo zsh-syntax-highlighting ssh-agent)

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
alias e="emacs -nw"
alias directorysize="du --max-depth=1 -h"
alias ldir="ls --color=auto -lahd */"
alias clavier-fr="setxkbmap fr"
alias clavier-us="setxkbmap us"
alias cdws="cd ~/workspace"

export BLACKFIRE_CLIENT_ID="049b0975-a4ba-4d93-9bd4-86c2d6ff9219"
export BLACKFIRE_CLIENT_TOKEN="561c385cbc9d212a13b2a6ef9368b30498e04471599a5121a1d8a53c375fc678"
export BLACKFIRE_SERVER_ID="cac3174e-a1ae-4610-94c8-abfe878dd6a6"
export BLACKFIRE_SERVER_TOKEN="4cc71431c8777a2018ce6af6e0ff134a5ec4d898e5e8a29338bd8e6f458ba4f4"


gbkp () { # Done in a function because in a alias date is run at start and not when the alias is called
	BACKUP=$(current_branch)-backup-$(date +%Y%m%d%H%M%S)
	echo Création d\'une sauvegarde dans $BACKUP
	git branch $BACKUP
}

ssh-restart() {
	_ssh_env_cache="$HOME/.ssh/environment-$SHORT_HOST"
	local lifetime
	local -a identities

	# start ssh-agent and setup environment
	zstyle -s :omz:plugins:ssh-agent lifetime lifetime

	ssh-agent -s ${lifetime:+-t} ${lifetime} | sed 's/^echo/#echo/' >! $_ssh_env_cache
	chmod 600 $_ssh_env_cache
	. $_ssh_env_cache > /dev/null

	# load identies
	zstyle -a :omz:plugins:ssh-agent identities identities

	echo starting ssh-agent...
	ssh-add $HOME/.ssh/${^identities}
}

# rebase $i number of commit
for i in `seq 2 10`; do alias rb$i="grbi @~$i"; done

alias gbkpd="git branch --no-color | grep backup- | xargs -n 1 git branch -d"
alias gbkpD="git branch --no-color | grep backup- | xargs -n 1 git branch -D"
alias grbdev="gbkp && git fetch --all --prune && git rebase origin/develop && git status"

alias server="python -m SimpleHTTPServer"
alias serverphp="php -S localhost:8000"


# SHIPPEO related

alias cdbe="cd ~/workspace/shippeo.backend"
alias cdsf="cd ~/workspace/shippeo.sf"
alias cdfr="cd ~/workspace/shippeo.frontend"

source ~/workspace/shippeo.backend/bin/bash-aliases.sh
