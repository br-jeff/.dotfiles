# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

alias pj='cd "$(find ~/Documents/projects --preview -maxdepth 1 -type d | grep -v "^$" | fzf-tmux -p --reverse --preview "echo {}")"'
alias pjo='nvim +cd "$(find ~/Documents/projects -maxdepth 1 -type d | grep -v "^$" | fzf-tmux -p --reverse --preview "echo {}")"'

alias gp='cd "$(find ~/Documents/gitpersonal -maxdepth 1 -type d | grep -v "^$" | fzf-tmux -p --reverse --preview "echo {}")"'
alias gpo='nvim +cd "$(find ~/Documents/gitpersonal -maxdepth 1 -type d | grep -v "^$" | fzf-tmux -p --reverse --preview "echo {}")"'
alias dotfiles='cd ~/.dotfiles'

alias ls='eza -lh --group-directories-first --icons'
alias lsa='ls -a'

# Git
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

alias ff="fzf --preview 'batcat --style=numbers"
alias lta='lt -a'

alias bat='batcat'
alias lzg='lazygit'
alias lzd='lazydocker'
alias lt='eza --tree --level=2 --long --icons --git'

# alias zellij='/snap/bin/zellij'
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)


# Add java home
. ~/.asdf/plugins/java/set-java-home.zsh

# start default version of codes
asdf global nodejs 14.21.3
asdf global java adoptopenjdk-17.0.0+35
asdf global golang 1.20.2
asdf global maven 3.5.4


export GOROOT=~/.asdf/installs/golang/1.20.2/go

export GO111MODULE=on

zinit ice depth=1
zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zdharma/history-search-multi-word
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
autoload -U compinit && compinit

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt HIST_EXPIRE_DUPS_FIRST

bindkey '^f' autosuggest-accept
bindkey '^p' hist-search-backward
bindkey '^n' history-search-forward

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf:tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

zstyle ':completion:*' fzf-search-display true

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

