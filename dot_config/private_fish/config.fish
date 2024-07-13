if status is-interactive
    # Commands to run in interactive sessions can go here
	alias che="chezmoi edit"
	alias "v"="nvim"
	alias ".."="cd .."
	alias ls="eza --icons"
	alias la="eza --icons --all"
	alias ll="eza --icons --long"

	# xdg-ninja
	export XDG_DATA_HOME="$HOME/.local/share"
	export XDG_CONFIG_HOME="$HOME/.config"
	export XDG_STATE_HOME="$HOME/.local/state"
	export XDG_CACHE_HOME="$HOME/.cache"
	export W3M_DIR="$XDG_DATA_HOME"/w3m
	export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
	export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
	export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
	export TERMINFO="$XDG_DATA_HOME"/terminfo
	export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
	export NBRC_PATH="$XDG_CONFIG_HOME/nbrc"
	export NB_DIR="$XDG_DATA_HOME/nb"
	export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
	export LESSHISTFILE="$XDG_STATE_HOME"/less/history
	export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
	export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
	export GOPATH="$XDG_DATA_HOME"/go
	export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
	export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

	fish_add_path -p "$HOME"/.cargo/bin ~/.local/bin/
	export EDITOR="nvim"

	starship init fish | source
	zoxide init fish | source
	fzf --fish | source
end

function fish_greeting
	fastfetch
end
