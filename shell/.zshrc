export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$PATH" >> ~/.zshrc

ZSH_THEME="robbyrussell"

if [ "$TMUX" = "" ]; then tmux; fi
tmux source-file ~/.tmux.conf


source $ZSH/oh-my-zsh.sh
