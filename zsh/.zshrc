export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="jonathan"
zstyle ':omz:update' mode auto      # update automatically without asking
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use)
source $ZSH/oh-my-zsh.sh
alias l="eza -l --icons --git -a --group-directories-first --no-permissions --no-user --no-time"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
