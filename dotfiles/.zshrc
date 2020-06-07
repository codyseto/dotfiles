#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# Alias
alias ...="../.."
alias ....="../../.."
alias .....="../../../.."
alias ......="../../../../.."
alias .......="../../../../../.."
alias g="git"
compdef g=git
alias gc='git commit -m'
alias gps='git push'
alias gpsu='git push -u origin'
alias gp='git pull origin'
alias gf='git fetch'
alias gfp='git fetch -p'
alias gd='git diff'
alias gco='git checkout'
alias gst="git status"
alias gcob='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gbr='git branch -r'
alias v="nvim"
alias vim="nvim"
# unalias gcc
# unalias rm

# PATH
export PATH=$PATH:/usr/local/texlive/2015/bin/x86_64-darwin
export PATH=$PATH:/usr/local/Cellar
export PATH=/usr/local/Cellar/ctags/5.8_1/bin:$PATH
export PATH=/usr/local/Cellar/ctags/5.8_1/bin:$PATH
export PATH=/usr/local/opt/php@7.2/bin:$PATH
export PATH=/usr/local/opt/php@7.2/sbin:$PATH
export PATH=$HOME/google-cloud-sdk/bin:$PATH
export PATH=$HOME/opt/anaconda3/bin:$PATH

# Vim Upgrade
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

# NeoVim
export XDG_CONFIG_HOME=$HOME/.config

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=C

# z
. /usr/local/etc/profile.d/z.sh

# fzf
fbr(){
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fbrm(){
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fshow(){
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

fvim(){
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  vim $selected_files
}

fga(){
  modified_files=$(git status --short | awk '{print $2}') &&
  selected_files=$(echo "$modified_files" | fzf -m --preview 'git diff {}') &&
  git add $selected_files
}

f(){
  vim "$(fzf --preview 'head -100 {}')"
}
zle -N f
#bindkey '^t' vim-fzf
#export FZF_CTRL_T_COMMAND="vim $(fzf)"
#export FZF_CTRL_T_OPTS="--preview 'head -100 {}'"

fzf-z-search(){
    local res=$(z | sort -rn | cut -c 12- | fzf)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}
zle -N fzf-z-search
bindkey '^k' fzf-z-search

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/setoyama/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/setoyama/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/setoyama/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/setoyama/google-cloud-sdk/completion.zsh.inc'; fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/setoyama/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/setoyama/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/setoyama/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/setoyama/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
