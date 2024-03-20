# vim: filetype=sh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
HIST_STAMPS="yyy/mm/dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump magic-enter sudo web-search colorize vi-mode)

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

source $ZSH/oh-my-zsh.sh

# USER CONFIGURATION ========================================================================

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

export NVIM_APPNAME=LazyVim # default nvim
export EDITOR=nvim
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/home/$USER/.local/bin"
export PATH="$PATH:/nix/var/nix/profiles/default/bin"

eval "$(direnv hook zsh)"

# fix for tilix : https://gnunn1.github.io/tilix-web/manual/vteconfig/ --------
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

# pnpm ------------------------------------------------------------------------
alias p="pnpm"
alias pd="pnpm dev"

# nvim ------------------------------------------------------------------------
v() {
	# runs nvim in a nix-shell with nodejs_20 + extra packages
	NODE_PKG="nodejs_20"
	PACKAGES=($NODE_PKG lazygit)
	NPM_GLOBAL_DIR="/home/$USER/.npm-global/$NODE_PKG"
	mkdir -p $NPM_GLOBAL_DIR
	PATH=$NPM_GLOBAL_DIR/bin:$PATH
	NPM_CONFIG_PREFIX=$NPM_GLOBAL_DIR
	echo "running vim $1 ($NVIM_APPNAME)"
	echo "using nix-shell with packages: "${PACKAGES[@]}""
	nix-shell -p "${PACKAGES[@]}" --run "nvim $1"
}

alias vv="v ."
alias vz="v ~/.zshrc"
alias voh="v ~/.oh-my-zsh"
alias vc="v ~/.config/lvim/config.lua"

# vscode ----------------------------------------------------------------------
c() {
	NIXPKGS_ALLOW_UNFREE=1 nix-shell -p vscode --command zsh --run "code $1"
}
alias cc="c ."

# various ---------------------------------------------------------------------
alias btop="/usr/local/bin/btop --utf-force"
alias micro="nix-shell -p micro --run micro"
alias nano="echo 'Using micro instead of nano'; micro"

# NVIM SWITCHER ---------------------------------------------------------------
# https://gist.github.com/elijahmanor/b279553c0132bfad7eae23e34ceb593b
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

function nvims() {
	items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
	config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
	if [[ -z $config ]]; then
		echo "Nothing selected"
		return 0
	elif [[ $config == "default" ]]; then
		config=""
	fi
	NVIM_APPNAME=$config nvim $@
}
bindkey -s ^a "nvims\n"
# END NVIM SWITCHER -----------------------------------------------------------
