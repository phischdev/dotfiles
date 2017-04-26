#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


alias wifi='sudo wifi-menu'
alias wieth='wifi && vpneth'
alias vpneth='sudo openconnect sslvpn.ethz.ch'
export PATH="/home/philipp/bin/Sencha/Cmd:$PATH"
