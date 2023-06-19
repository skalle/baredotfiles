# Keychain
keychain ~/.ssh/id_ed25519
. ~/.keychain/${HOST}-sh

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

alias ha='history 0'
# Some cool bare dotfiles stuff.
alias config='/usr/bin/git --git-dir=/home/olak/.cfg/ --work-tree=/home/olak'

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
   nvim ${cols[1]} +"normal! ${cols[2]}zz"
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
#
# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Some basic addons.
zcomet load zsh-users/zsh-completions
zcomet load zsh-users/zsh-history-substring-search
zcomet load zdharma/fast-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions

# Fzy rules.
zcomet load aperezdc/zsh-fzy
zcomet load hcgraf/zsh-sudo

# A nice prompt.
zcomet load romkatv/powerlevel10k

# Run compinit and compile its cache
zcomet compinit

# Double escape -> sudo
zcomet load ohmyzsh plugins/sudo

## End plugins


bindkey '\ec' fzy-cd-widget
bindkey '^T'  fzy-file-widget
bindkey '^R'  fzy-history-widget
bindkey '^P'  fzy-proc-widget

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

# Direnv
eval "$(direnv hook zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/olak/CloudSDK/google-cloud-sdk/path.zsh.inc' ]; then . '/home/olak/CloudSDK/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/olak/CloudSDK/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/olak/CloudSDK/google-cloud-sdk/completion.zsh.inc'; fi

