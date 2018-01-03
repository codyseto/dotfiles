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
alias gst="git status"
alias v="nvim"
alias vim="nvim"
unalias gcc
unalias rm

# PATH
export PATH=$PATH:/usr/local/texlive/2015/bin/x86_64-darwin
export PATH=$PATH:/usr/local/Cellar

# CUDA
export PATH=$PATH:/usr/local/cuda/bin
export CPATH=$CPATH:/usr/local/cuda/include
export CUDA_ROOT=/usr/local/cuda
export CUDA_INC_DIR=/usr/local/cuda/bin:$CUDA_INC_DIR
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib

# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
export PATH=$PYENV_ROOT/versions/anaconda3-2.3.0/bin/:$PATH

# NeoVim
export XDG_CONFIG_HOME=$HOME/.config
