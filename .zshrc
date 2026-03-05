##### POWERLEVEL10K INSTANT PROMPT (TOP ONLY)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##### COMPLETION
ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
autoload -Uz compinit
compinit -C -d "$ZSH_COMPDUMP"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

##### PLUGINS
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# MUST BE LAST PLUGIN
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

##### POWERLEVEL10K
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

####LOOk and fEEl
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7a847f"

##### PYWAL
#cat ~/.cache/wal/sequences
#source ~/.cache/wal/colors-tty.sh


##### ALIASES
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --git --header --group-directories-first"
alias lt="eza --tree --level=2"
alias display='xrandr --output eDP --mode 1920x1200 --rate 165 --output HDMI-1-0 --primary --mode 1920x1080 --rate 100 --right-of eDP'
alias wallpaper='feh --bg-fill --randomize /home/moon/Pictures/Wallpaper/*'

alias power='cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'
alias performance='sudo cpupower frequency-set -g performance'
alias battery='sudo cpupower frequency-set -g powersave'


##### FUNCTIONS
download() {
  aria2c -x 16 -s 16 -k 1M "$@"
}

##### HISTORY
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=5000
setopt INC_APPEND_HISTORY SHARE_HISTORY EXTENDED_HISTORY APPENDHISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
export HISTTIMEFORMAT="%d/%m/%Y %H:%M "

##### ENV
export LIBVIRT_DEFAULT_URI="qemu:///system"

##### OPTIONAL: Dart completion
[[ -f "$HOME/.config/.dart-cli-completion/zsh-config.zsh" ]] \
  && source "$HOME/.config/.dart-cli-completion/zsh-config.zsh"

