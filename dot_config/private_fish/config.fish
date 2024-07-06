if status is-interactive
    # Commands to run in interactive sessions can go here
	alias che="chezmoi edit"
	alias "v"="nvim"
	alias ".."="cd .."
	alias ls="eza --icons"
	alias la="eza --icons --all"
	alias ll="eza --icons --long"

	export PATH="$HOME/.node_modules_global/bin:$PATH"
	export EDITOR="nvim"

	starship init fish | source
	zoxide init fish | source
	fzf --fish | source
end

function fish_greeting
	fastfetch
end
