source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
bindkey '^V' bracketed-paste

eval "$(starship init zsh)"
fastfetch
cowsay Feito com carinho por @Lu1z.jpeg

alias lava='lavat -c magenta -r 8 -s 1.5'
