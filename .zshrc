##### POWERLEVEL10K INSTANT PROMPT (TOP ONLY)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##### COMPLETION
ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"

##### PLUGINS
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# MUST BE LAST PLUGIN
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

##### POWERLEVEL10K
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

##### ALIASES
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --git --header --group-directories-first"
alias lt="eza --tree --level=2"

##### FUNCTIONS
download() {
  aria2c -x 16 -s 16 -k 1M "$@"
}

##### HISTORY
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=5000
setopt INC_APPEND_HISTORY SHARE_HISTORY EXTENDED_HISTORY APPENDHISTORY
export HISTTIMEFORMAT="%d/%m/%Y %H:%M "

##### ENV
export LIBVIRT_DEFAULT_URI="qemu:///system"

##### OPTIONAL: Dart completion
[[ -f "$HOME/.config/.dart-cli-completion/zsh-config.zsh" ]] \
  && source "$HOME/.config/.dart-cli-completion/zsh-config.zsh"

