# /etc/profile を読み込まない設定
setopt no_global_rcs

# Directory path to zsh setting
export ZDOTDIR=$HOME/dotfiles/.zsh
source $ZDOTDIR/.zshenv

# 以降の読み込まれる順番
# /etc/zshenv
# $ZDOTDIR/.zshenv
# /etc/zprofile
# $ZDOTDIR/.zprofile
# /etc/zshrc
# $ZDOTDIR/.zshrc
# /etc/zlogin
# $ZDOTDIR/.zlogin

