# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# User configuration
HISTFILE="$HOME/.histfile"
HISTSIZE=15000
SAVEHIST=15000

alias ha='history'
alias nvim='nv'
PATH=$PATH:~/bin:~/go/bin:~/.local/bin:~/.cargo/bin/
EDITOR=/usr/bin/nvim
#xmodmap ~/.Xmodmap

### fzf ############################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='-m --color fg:-1,bg:-1,hl:120,fg+:3,bg+:233,hl+:229 --color info:140,prompt:120,spinner:150,pointer:167,marker:174'

# fe - Open the selected files with the default editor
fe() {
   local files=$(fzf --query="$1" --select-1 --exit-0 | sed -e "s/\(.*\)/\'\1\'/")
   local command="${EDITOR:-vim} -p $files"
   [ -n "$files" ] && eval $command
}

# fag - find an argument with ag and fzf and open with vim
fag() {
 [ $# -eq 0  ] && return
 local out cols
 if out=$(ag --nogroup --color "$@" | fzf --ansi); then
   setopt sh_word_split
   cols=(${out//:/  })
   unsetopt sh_word_split
   vim ${cols[1]} +"normal! ${cols[2]}zz"
 fi
}

# cdf - cd into the directory of the selected file\
cdf() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

fep() {
    local files=$(fzf --query="$1" --select-1 --exit-0 --preview="bat --color=always {}" --preview-window=right:50%:wrap | sed -e "s/\(.*\)/\'\1\'/")
    local command="${EDITOR:-vim} -p $files"
    [ -n "$files" ] && eval $command
}
#####################################


### Added by Zplugin's installer
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zplugin installer's chunk

zinit ice wait blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit light zsh-users/zsh-history-substring-search

zinit ice wait atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice wait atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit snippet OMZ::/lib/history.zsh

zinit light aperezdc/zsh-fzy
bindkey '\ec' fzy-cd-widget
bindkey '^T'  fzy-file-widget
bindkey '^R'  fzy-history-widget
bindkey '^P'  fzy-proc-widget

zinit ice depth=1; zinit light romkatv/powerlevel10k

# Let's see if this works.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Starship prompt stuff
# eval "$(starship init zsh)"
typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(direnv hook zsh)"
alias config='/usr/bin/git --git-dir=/home/olak/.cfg/ --work-tree=/home/olak'
