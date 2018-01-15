#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias cat='vimcat'
alias wifi='sudo wifi-menu'
alias wieth='wifi && vpneth'
alias vpneth='sudo openconnect sslvpn.ethz.ch'
alias service='sudo systemctl'
#alias xbacklight='sudo /usr/local/bin/xbacklight'
export PATH="/home/philipp/bin/Sencha/Cmd:$PATH"
alias lss='ls -haltr'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
