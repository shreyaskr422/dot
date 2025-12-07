if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"

autoload -Uz compinit

if [[ -f "$ZSH_COMPDUMP" && "$ZSH_COMPDUMP" -nt ~/.zshrc ]]; then
    compinit -C -d "$ZSH_COMPDUMP"
else
    compinit -d "$ZSH_COMPDUMP"
fi

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

alias ls="eza --icons --group-directories-first"
alias ll="eza -la --git --header --group-directories-first"
alias lt="eza --tree --level=2"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
